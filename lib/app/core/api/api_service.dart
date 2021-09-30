import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../exports_pmsc.dart';

abstract class IApiService {}

class ApiService extends IApiService {
  final Dio _dio;
  final StorageService _storage;

  ApiService(this._dio, this._storage);

  ///Configura a otilizacao da api para fazer requisicao
  Future<Dio> getApiClient(String app, String? url) async {
    final token = await _storage.getToken();
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
          final refreshToken = await _storage.getRefreshToken();
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
}
