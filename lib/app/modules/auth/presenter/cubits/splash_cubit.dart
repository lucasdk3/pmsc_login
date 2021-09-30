import '../../../../../exports_pmsc.dart';

enum SplashState { init, loading }

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._storage) : super(SplashState.init);

  final IStorageService _storage;

  void verifyAuth() async {
    emit(SplashState.loading);
    await _storage.getToken() == null &&
            await _storage.getRefreshToken() == null
        ? AppRouter.instance.to('auth')
        : AppRouter.instance.to('base');
  }
}
