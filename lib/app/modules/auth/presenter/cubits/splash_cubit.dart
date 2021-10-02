import '../../../../../exports_pmsc.dart';

enum SplashState { init, loading, success, error }

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._storage) : super(SplashState.init);

  final IStorageService _storage;

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 3), () {
      if (_storage.getToken() == null && _storage.getRefreshToken() == null) {
        emit(SplashState.error);
      } else {
        emit(SplashState.success);
      }
    });
  }
}
