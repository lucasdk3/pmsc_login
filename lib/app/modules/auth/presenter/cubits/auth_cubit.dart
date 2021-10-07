import 'package:flutter/material.dart';
import '../../../../../exports_pmsc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authUseCase, this._authWithFingerUseCase, this._logoutUseCase)
      : super(AuthInit());

  final IAuthUseCase _authUseCase;
  final IAuthWithFingerUseCase _authWithFingerUseCase;
  final ILogoutUseCase _logoutUseCase;

  final registrationController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> auth() async {
    emit(AuthLoading());
    final registration = registrationController.text;
    final password = passwordController.text;
    final result = await _authUseCase.call(
        entity: AuthEntity(registration: registration, password: password));
    result == null ? emit(AuthSuccess()) : emit(AuthError(result));
  }

  Future<void> authWithFinger() async {
    emit(AuthLoading());
    final result = await _authWithFingerUseCase.call();
    result ? emit(AuthSuccess()) : emit(AuthError('error'));
  }

  Future<void> logout(Function toLogin) async {
    emit(AuthLoading());
    _logoutUseCase.call(toLogin: toLogin);
    emit(AuthInit());
  }
}
