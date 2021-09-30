import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class IStorageService {
  Future<void> setToken({required String token});
  Future<void> setRefreshToken({required String refreshToken});
  Future<void> setRegistration({required String registration});
  Future<void> setPassword({required String password});
  Future<String?> getToken();
  Future<String?> getRefreshToken();
  Future<String?> getRegistration();
  Future<String?> getPassword();
}

class StorageService implements IStorageService {
  final storage = const FlutterSecureStorage();

  @override
  Future<String?> getRefreshToken() async =>
      await storage.read(key: 'refresh_token');

  @override
  Future<String?> getToken() async => await storage.read(key: 'token');

  @override
  Future<void> setRefreshToken({required String refreshToken}) async =>
      await storage.write(key: 'refresh_token', value: refreshToken);

  @override
  Future<void> setToken({required String token}) async =>
      await storage.write(key: 'token', value: token);

  @override
  Future<String?> getPassword() async => await storage.read(key: 'password');

  @override
  Future<String?> getRegistration() async =>
      await storage.read(key: 'registration');

  @override
  Future<void> setPassword({required String password}) async =>
      await storage.write(key: 'password', value: password);

  @override
  Future<void> setRegistration({required String registration}) async =>
      await storage.write(key: 'registration', value: registration);
}
