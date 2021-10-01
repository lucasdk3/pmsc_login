import 'package:localstorage/localstorage.dart';
import 'package:pmsc_auth/exports_pmsc.dart';

abstract class IStorageService {
  Future<void> setToken({required String token});
  Future<void> setRefreshToken({required String refreshToken});
  Future<void> setRegistration({required String registration});
  Future<void> setPassword({required String password});
  String? getToken();
  String? getRefreshToken();
  String? getRegistration();
  String? getPassword();
}

class StorageService implements IStorageService {
  final encrypt = Encrypt();
  final _storage = LocalStorage('MKTP');

  @override
  String? getRefreshToken() => _storage.getItem('refresh_token');

  @override
  String? getToken() => _storage.getItem('token');

  @override
  Future<void> setRefreshToken({required String refreshToken}) async =>
      await _storage.setItem('refresh_token', refreshToken);

  @override
  Future<void> setToken({required String token}) async =>
      await _storage.setItem('token', token);

  @override
  String? getPassword() {
    final valueStorage = _storage.getItem('password');
    final encryptData = encrypt.from(valueStorage);
    return encryptData;
  }

  @override
  String? getRegistration() {
    final valueStorage = _storage.getItem('registration');
    final encryptData = encrypt.from(valueStorage);
    return encryptData;
  }

  @override
  Future<void> setPassword({required String password}) async =>
      await _storage.setItem('password', password);

  @override
  Future<void> setRegistration({required String registration}) async =>
      await _storage.setItem('registration', registration);
}
