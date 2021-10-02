import '../../../../../exports_pmsc.dart';

class AuthDatasourceImpl extends IAuthDatasouce {
  final IApiService _api;

  AuthDatasourceImpl(this._api);

  @override
  Future<UserModel> call(AuthModel model) async {
    final response =
        await _api.get(apiRequest: getUser(AuthModel.toMap(model)));
    if (response.hasError) {
      throw ErrorResponse();
    } else {
      return UserModel.fromJson(response.body);
    }
  }
}
