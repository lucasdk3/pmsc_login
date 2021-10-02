import 'dart:convert';

import '../../../../../exports_pmsc.dart';

ApiRequest getUser(Map<String, dynamic> auth) => ApiRequest(
    path: ConfigService.baseUrl + '/user',
    body: auth,
    deleteOnError: false,
    mockSimulate: userResponse);

ApiResponse userResponse = ApiResponse(
  body: jsonDecode(AuthMocks.userResponse),
  statusCode: 200,
);
