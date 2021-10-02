import '../../../../../exports_pmsc.dart';

abstract class IAuthDatasouce {
  Future<UserModel> call(AuthModel model);
}
