import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pmsc_auth/exports_pmsc.dart';

import '../../../../../mocks.dart';

void main() {
  late IAuthUseCase _authUseCase;
  late ILogoutUseCase _logoutUseCase;
  late IAuthWithFingerUseCase _authWithFingerUseCase;
  late AuthCubit _authCubit;
  setUp(() {
    _authUseCase = AuthUseCaseMock();
    _logoutUseCase = LogoutUseCaseMock();
    _authWithFingerUseCase = AuthWithFingerUseCaseMock();
    _authCubit =
        AuthCubit(_authUseCase, _authWithFingerUseCase, _logoutUseCase);
    registerFallbackValue<AuthEntity>(AuthEntityFake());
    registerFallbackValue<Function>(() {});
  });

  group('AuthCubit Tests - ', () {
    group('auth | ', () {
      test('when request AuthUseCase, should return no error', () async {
        when(() => _authUseCase.call(entity: any(named: 'entity')))
            .thenAnswer((_) async => await null);
        await _authCubit.auth();
        expect(_authCubit.state, AuthSuccess());
      });

      test('when request AuthUseCase, should return error', () async {
        when(() => _authUseCase.call(entity: any(named: 'entity')))
            .thenAnswer((_) async => 'error');
        await _authCubit.auth();
        expect(_authCubit.state, AuthError('error'));
      });
    });

    group('authWithFinger | ', () {
      test('when request AuthWithFingerUseCase, should return true', () async {
        when(() => _authWithFingerUseCase.call()).thenAnswer((_) async => true);
        await _authCubit.authWithFinger();
        expect(_authCubit.state, AuthSuccess());
      });

      test('when request AuthUseCase, should return error', () async {
        when(() => _authWithFingerUseCase.call())
            .thenAnswer((_) async => false);
        await _authCubit.authWithFinger();
        expect(_authCubit.state, AuthError('error'));
      });
    });

    group('logout | ', () {
      test('when request AuthUseCase, should return AuthInit', () async {
        when(() => _logoutUseCase.call(toLogin: any(named: 'toLogin')))
            .thenAnswer((_) async => 'ok');
        await _authCubit.logout(() {});
        expect(_authCubit.state, AuthInit());
      });
    });
  });
}
