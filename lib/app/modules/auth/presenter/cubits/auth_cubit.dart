import 'package:flutter/material.dart';
import '../../../../../exports_pmsc.dart';

enum AuthState { init, success, error, loading }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.init);

  final registrationController = TextEditingController();
  final passwordController = TextEditingController();

  void auth() async {
    emit(AuthState.loading);
    final registration = registrationController.text;
    final password = passwordController.text;
    // final result = _authUseCase
    //      .call(AuthEntity(registration: registration, password: password));
  }

  void authWithFinger() async {
    emit(AuthState.loading);
    //final result = _authWithFingerUseCase.call();
  }

  void logout() async {
    emit(AuthState.loading);
    // _logoutUseCase.call();
    emit(AuthState.init);
  }
}
