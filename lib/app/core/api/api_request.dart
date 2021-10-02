import 'dart:async';

import '../../../exports_pmsc.dart';

class ApiRequest {
  const ApiRequest({
    required this.path,
    this.body = const {},
    this.cancelToken,
    this.queryParameters = const {},
    this.deleteOnError = true,
    this.onReceiveProgress,
    this.onSendProgress,
    this.tryParse,
    this.mockSimulate,
  });

  final String path;
  final dynamic body;
  final Map<String, dynamic> queryParameters;
  final Completer? cancelToken;
  final bool deleteOnError;
  final dynamic Function(Map<String, dynamic> map)? tryParse;
  final Function(int count, int total)? onSendProgress;
  final Function(int count, int total)? onReceiveProgress;
  final ApiResponse? mockSimulate;
}
