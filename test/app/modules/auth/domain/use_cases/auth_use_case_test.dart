import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pmsc_auth/exports_pmsc.dart';
import 'package:dartz/dartz.dart';
import '../../../../../mocks.dart';

void main() {
  late IAuthUseCase _useCase;
  late IAuthRepository _repository;
  late IStorageService _storage;
  setUp(() {
    _storage = StorageService();
    _repository = AuthRepositoryMock();
    _useCase = AuthUseCase(_storage, _repository);
  });

  group('AuthUseCase Tests - ', () {
    group('auth | ', () {
      test('when request AuthUseCase, should return no error', () async {
        when(() => _repository.call(entity: Mocks.authModel.toEntity))
            .thenAnswer((_) async => right(Mocks.userModel.toEntity));
        var result = await _useCase.call(entity: Mocks.authModel.toEntity);
        expect(result, null);
      });

      test('when request AuthUseCase, should return Erro na API', () async {
        when(() => _repository.call(entity: Mocks.authModel.toEntity))
            .thenAnswer((_) async => left(ErrorResponse()));
        var result = await _useCase.call(entity: Mocks.authModel.toEntity);
        expect(result, 'Erro na API');
      });

      test(
          'when request AuthUseCase, should return false, because registration is invalid',
          () async {
        when(() => _repository.call(
                entity: Mocks.authModelWithInvalidRegistration.toEntity))
            .thenAnswer((_) async => right(Mocks.userModel.toEntity));
        var result = await _useCase.call(
            entity: Mocks.authModelWithInvalidRegistration.toEntity);
        expect(result, 'Mátricula inválida');
      });

      test(
          'when request AuthUseCase, should return false, because password is invalid',
          () async {
        when(() => _repository.call(
                entity: Mocks.authModelWithInvalidPassword.toEntity))
            .thenAnswer((_) async => right(Mocks.userModel.toEntity));
        var result = await _useCase.call(
            entity: Mocks.authModelWithInvalidPassword.toEntity);
        expect(result, 'Senha inválida');
      });
    });
  });
}
