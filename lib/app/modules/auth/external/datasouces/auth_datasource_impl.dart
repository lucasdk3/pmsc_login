import '../../../../../exports_pmsc.dart';

class AuthDatasourceImpl extends IAuthDatasouce {
  final IApiService _api;

  AuthDatasourceImpl(this._api);

  @override
  Future<UserModel> call(AuthEntity entity) {
    throw UnimplementedError();
  }
}
