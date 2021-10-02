import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../exports_pmsc.dart';

abstract class IAuthUseCase {
  Future<bool> call(AuthEntity entity);
}

class AuthUseCase extends IAuthUseCase {
  final IStorageService _storage;
  final IAuthRepository _repository;

  AuthUseCase(this._storage, this._repository);
  @override
  Future<bool> call(AuthEntity entity) async {
    final isValid = AuthValidate.call(entity.registration, entity.password);
    if (isValid) {
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
