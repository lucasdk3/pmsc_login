import '../../../../../exports_pmsc.dart';

abstract class IAuthUseCase {
  Future<void> call(AuthEntity entity);
}

class AuthUseCase extends IAuthUseCase {
  final IStorageService _storage;
  final IAuthRepository _repository;

  AuthUseCase(this._storage, this._repository);
  @override
  Future<void> call(AuthEntity entity) async {
    final isValid = AuthValidate.call(entity.registration, entity.password);
    if (isValid) {
      final result = _repository.call();
      _storage.setRegistration(registration: entity.registration);
      _storage.setPassword(password: entity.password);
    } else {}
  }
}
