import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../exports_pmsc.dart';

abstract class IApiService {
  Map<String, dynamic> header() => throw UnimplementedError();

  bool get enableMockResponse => false;

  String get token => throw UnimplementedError();

  String get baseUrl => throw UnimplementedError();

  Map<String, dynamic> get customHeaderParam => throw UnimplementedError();

  Future<ApiResponse<T>> get<T>({required ApiRequest apiRequest});

  Future<ApiResponse<T>> post<T>({required ApiRequest apiRequest});

  Future<ApiResponse<T>> put<T>({required ApiRequest apiRequest});
}

class ApiService extends IApiService {
  final Dio _dio;
  final IStorageService _storage;

  ApiService(this._dio, this._storage);

  ///Configura a otilizacao da api para fazer requisicao
  Future<Dio> getApiClient(String app, String? url) async {
    final token = _storage.getToken();
    var baseUrl = (url ?? ConfigService.baseUrl);
    try {
      _dio.interceptors.clear();
      _dio.options.baseUrl = baseUrl;
      if (kDebugMode) {
        print("Url=> $baseUrl");
      }
      _dio.interceptors.add(InterceptorsWrapper(onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        // Do something before request is sent
        var header = getHeaderToken(token: token);
        options.headers = header;

        options.connectTimeout = 50 * 1000; // 60 seconds
        options.receiveTimeout = 50 * 1000; // 60 seconds
      }, onResponse: (Response response, ResponseInterceptorHandler handler) {
        response;
        handler.next(response); // continue
      }, onError: (DioError error, ErrorInterceptorHandler handler) async {
        // Do something with response error
        if (error.response?.statusCode == 403) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();
          if (kDebugMode) {
            print("refresh token");
          }
          final refreshToken = _storage.getRefreshToken();
          RequestOptions? options = error.response?.requestOptions;
          final header = getHeaderToken(token: refreshToken);
          options?.headers = header;

          var url = ConfigService.baseUrl;
          final response = await http.get(
              Uri.parse(url + "backoffice-api/user/token/refresh"),
              headers: {
                'Authorization': 'Bearer $refreshToken'
              }).timeout(const Duration(seconds: 15));
          var responseData =
              response.body != "" ? jsonDecode(response.body) : {};
          var statusCode = response.statusCode;
          _dio.interceptors.responseLock.unlock();
          _dio.interceptors.requestLock.unlock();
          if (statusCode == 200) {
            _storage.setToken(token: responseData["token"]);
            _storage.setRefreshToken(
                refreshToken: responseData["refresh_token"]);

            var headers = getHeaderToken(token: responseData["token"]);

            options?.headers.clear();
            options?.headers = headers;
          } else {
            //_auth.logout();
            error;
          }

          _dio.interceptors.responseLock.unlock();
          _dio.interceptors.requestLock.unlock();
          error;
        } else {
          error;
        }
      }));
      // ignore: empty_catches
    } catch (e) {}
    return _dio;
  }

  static Map<String, String> getHeaderToken({String? token}) {
    if (token == null) {
      return <String, String>{
        'content-Type': 'application/json',
        'accept': 'application/json',
      };
    } else {
      return <String, String>{
        'content-Type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
    }
  }

  @override
  Future<ApiResponse<T>> get<T>({required ApiRequest apiRequest}) async {
    if (!apiRequest.deleteOnError ||
        (enableMockResponse && apiRequest.mockSimulate != null)) {
      return _mockSimulate(apiRequest);
    }
    try {
      final response = await _dio.get(apiRequest.path,
          queryParameters: apiRequest.queryParameters,
          onReceiveProgress: apiRequest.onSendProgress);
      return _bodySuccessOnResponse(apiRequest, response);
    } on DioError catch (error) {
      return _bodyDioErrorOnResponse(error, apiRequest);
    } on Exception catch (error) {
      return _bodyErrorOnResponse(error, apiRequest);
    }
  }

  @override
  Future<ApiResponse<T>> post<T>({required ApiRequest apiRequest}) async {
    if (!apiRequest.deleteOnError ||
        (enableMockResponse && apiRequest.mockSimulate != null)) {
      return _mockSimulate(apiRequest);
    }
    try {
      final response = await _dio.post(apiRequest.path,
          data: apiRequest.body,
          queryParameters: apiRequest.queryParameters,
          onReceiveProgress: apiRequest.onSendProgress,
          onSendProgress: apiRequest.onReceiveProgress);
      return _bodySuccessOnResponse(apiRequest, response);
    } on DioError catch (error) {
      return _bodyDioErrorOnResponse(error, apiRequest);
    } on Exception catch (error) {
      return _bodyErrorOnResponse(error, apiRequest);
    }
  }

  @override
  Future<ApiResponse<T>> put<T>({required ApiRequest apiRequest}) async {
    if (!apiRequest.deleteOnError ||
        (enableMockResponse && apiRequest.mockSimulate != null)) {
      return _mockSimulate(apiRequest);
    }
    try {
      final response = await _dio.put(apiRequest.path,
          data: apiRequest.body,
          queryParameters: apiRequest.queryParameters,
          onReceiveProgress: apiRequest.onSendProgress,
          onSendProgress: apiRequest.onReceiveProgress);
      return _bodySuccessOnResponse(apiRequest, response);
    } on DioError catch (error) {
      return _bodyDioErrorOnResponse(error, apiRequest);
    } on Exception catch (error) {
      return _bodyErrorOnResponse(error, apiRequest);
    }
  }

  @override
  Map<String, dynamic> header({String token = ''}) {
    final header = token.isEmpty
        ? <String, dynamic>{'content-type': 'application/json;charset=utf-8'}
        : <String, dynamic>{
            'content-type': 'application/json;charset=utf-8',
            'Authorization': 'Bearer $token',
          };
    header.addAll(customHeaderParam);
    return header;
  }

  ApiResponse<T> _bodyErrorOnResponse<T>(
      Exception error, ApiRequest apiRequest) {
    final response =
        ApiResponse<T>(statusCode: 500, errorBody: error, request: apiRequest);
    return response;
  }

  ApiResponse<T> _bodyDioErrorOnResponse<T>(
      DioError error, ApiRequest apiRequest) {
    final response = ApiResponse<T>(
        statusCode: error.response?.statusCode ?? 500,
        errorBody: error.response?.data ??
            error.error ??
            error.message ??
            error.stackTrace,
        request: apiRequest);
    return response;
  }

  ApiResponse<T> _bodySuccessOnResponse<T>(
      ApiRequest apiRequest, Response<dynamic> response) {
    // ignore: prefer_typing_uninitialized_variables
    var resultData;
    try {
      if (apiRequest.tryParse != null) {
        resultData = apiRequest.tryParse?.call(response.data) as T?;
      } else {
        resultData = response.data;
      }
    } catch (e) {
      resultData = response.data;
    }
    if (resultData is T) {
      return ApiResponse<T>(
          statusCode: response.statusCode ?? 500,
          body: response.data,
          request: apiRequest);
    } else {
      return ApiResponse<T>(
          statusCode: response.statusCode ?? 500, errorBody: response.data);
    }
  }

  ApiResponse<T> _mockSimulate<T>(ApiRequest apiRequest) {
    debugPrint(
        '================================Request simulated=======================================================');
    debugPrint('Path simulated => ${apiRequest.path}');
    debugPrint('Body simulated => ${apiRequest.mockSimulate?.body}');
    debugPrint(
        '================================Request simulated=======================================================');
    var resultData;
    if (apiRequest.tryParse != null) {
      resultData =
          apiRequest.tryParse?.call(apiRequest.mockSimulate?.body ?? {}) as T?;
    } else {
      resultData = apiRequest.mockSimulate?.body ?? {};
    }
    if (resultData is T) {
      return ApiResponse<T>(
          statusCode: apiRequest.mockSimulate?.statusCode ?? 500,
          body: resultData,
          errorBody: apiRequest.mockSimulate?.errorBody,
          request: apiRequest);
    } else {
      return ApiResponse<T>(
        statusCode: apiRequest.mockSimulate?.statusCode ?? 500,
        errorBody: resultData,
        request: apiRequest,
      );
    }
  }
}
