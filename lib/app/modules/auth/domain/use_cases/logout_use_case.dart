import '../../../../../exports_pmsc.dart';

abstract class ILogoutUseCase {
  Future<void> call({required Function toLogin});
}

class LogoutUseCase extends ILogoutUseCase {
  final IStorageService _storage;

  LogoutUseCase(this._storage);
  @override
  Future<void> call({required Function toLogin}) async {
    toLogin();
    _storage.clear();
  }
}
