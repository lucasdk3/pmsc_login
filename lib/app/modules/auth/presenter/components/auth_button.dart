// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../exports_pmsc.dart';

class AuthButton extends BlocView<AuthCubit, AuthState> {
  AuthButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = state == AuthLoading();
    final width = !isLoading ? 0.64 : 0.8;
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state == AuthSuccess()) {
        AppRouter.instance.to('/base');
      } else if (state is AuthError) {
        Fluttertoast.showToast(msg: state.error);
      }
    }, builder: (context, state) {
      return state == AuthLoading()
          ? const Center(child: CircularProgressIndicator())
          : MaterialButton(
              height: 46,
              minWidth: MediaQuery.of(context).size.width * width,
              color: background,
              child: Stack(
                children: [
                  Visibility(
                    visible: isLoading,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !isLoading,
                    child: const Text(
                      'Entrar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      bottomRight: Radius.circular(!isLoading ? 0 : 12))),
              onPressed: () => bloc.auth());
    });
  }
}
