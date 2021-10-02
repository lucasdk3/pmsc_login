import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import '../../../../../exports_pmsc.dart';

abstract class IAuthWithFingerUseCase {
  Future<bool> call();
}

class AuthWithFingerUseCase extends IAuthWithFingerUseCase {
  final IStorageService _storage;
  final IAuthRepository _repository;

  AuthWithFingerUseCase(this._storage, this._repository);
  @override
  Future<bool> call() async {
    final localAuth = LocalAuthentication();
    bool isValid = await localAuth.authenticate(
        localizedReason: 'Please authenticate com sua digital',
        useErrorDialogs: true,
        stickyAuth: true,
        biometricOnly: true);
    if (isValid) {
      final entity = AuthEntity(
          registration: _storage.getRegistration() ?? '',
          password: _storage.getPassword() ?? '');
      final result = await _repository.call(entity: entity);
      return result.fold((l) {
        Fluttertoast.showToast(msg: 'Erro no login');
        return false;
      }, (r) {
        _storage.setRegistration(registration: entity.registration);
        _storage.setPassword(password: entity.password);
        return true;
      });
    } else {
      return false;
    }
  }
}
