import 'package:flutter/material.dart';
import '../../../../../exports_pmsc.dart';

enum AuthState { init, success, error, loading }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authUseCase, this._authWithFingerUseCase, this._logoutUseCase)
      : super(AuthState.init);

  final IAuthUseCase _authUseCase;
  final IAuthWithFingerUseCase _authWithFingerUseCase;
  final ILogoutUseCase _logoutUseCase;

  final registrationController = TextEditingController();
  final passwordController = TextEditingController();

  void auth() async {
    emit(AuthState.loading);
    final registration = registrationController.text;
    final password = passwordController.text;
    final result = await _authUseCase
        .call(AuthEntity(registration: registration, password: password));
    result ? emit(AuthState.success) : emit(AuthState.error);
  }

  void authWithFinger() async {
    emit(AuthState.loading);
    final result = await _authWithFingerUseCase.call();
    result ? emit(AuthState.success) : emit(AuthState.error);
  }

  void logout() async {
    emit(AuthState.loading);
    _logoutUseCase.call();
    emit(AuthState.init);
  }
}
