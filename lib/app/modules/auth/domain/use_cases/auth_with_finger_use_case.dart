import 'package:local_auth/local_auth.dart';
import '../../../../../exports_pmsc.dart';

abstract class IAuthWithFingerUseCase {
  Future<void> call();
}

class AuthWithFingerUseCase extends IAuthWithFingerUseCase {
  final IStorageService _storage;
  final IAuthRepository _repository;

  AuthWithFingerUseCase(this._storage, this._repository);
  @override
  Future<void> call() async {
    final localAuth = LocalAuthentication();
    bool isValid = await localAuth.authenticate(
        localizedReason: 'Please authenticate com sua digital',
        useErrorDialogs: true,
        stickyAuth: true,
        biometricOnly: true);
    if (isValid) {
      final auth = AuthEntity(
          registration: await _storage.getRegistration() ?? '',
          password: await _storage.getPassword() ?? '');
      final result = _repository.call();
    } else {}
  }
}
