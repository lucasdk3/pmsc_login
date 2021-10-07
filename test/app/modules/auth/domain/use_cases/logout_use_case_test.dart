import 'package:flutter_test/flutter_test.dart';
import 'package:pmsc_auth/exports_pmsc.dart';

void main() {
  late ILogoutUseCase _useCase;
  late IStorageService _storage;
  setUp(() {
    _storage = StorageService(storageKey: 'TEST');
    _useCase = LogoutUseCase(_storage);
  });

  group('LogoutUseCase Tests - ', () {
    group('auth | ', () {
      test('when request LogoutUseCase, storage items return null', () async {
        _storage.setToken(token: 'token');
        expect(_storage.getToken(), 'token');
        await _useCase.call(toLogin: () {});
        expect(_storage.getToken(), null);
      });
    });
  });
}
