import 'api_request.dart';

class ApiResponse<T> {
  const ApiResponse(
      {this.request,
      this.statusCode,
      this.bodyBytes,
      this.bodyString,
      this.statusText = '',
      this.headers = const {},
      this.body,
      this.errorBody});

  final ApiRequest? request;
  final Map<String, String>? headers;
  final int? statusCode;
  final String? statusText;
  final Stream<List<int>>? bodyBytes;
  final String? bodyString;
  final T? body;
  final dynamic errorBody;

  int get status => statusCode ?? 500;

  bool get isOk => status.clamp(200, 299) == status;

  bool get hasError => !isOk;

  bool get unauthorized => status == 401;
}
