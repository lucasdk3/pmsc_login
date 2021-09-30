import '../../../../../exports_pmsc.dart';

abstract class ILogoutUseCase {
  Future<void> call();
}

class LogoutUseCase extends ILogoutUseCase {
  final IStorageService _storage;

  LogoutUseCase(this._storage);
  @override
  Future<void> call() async {
    AppRouter.instance.to('/auth');
  }
}
