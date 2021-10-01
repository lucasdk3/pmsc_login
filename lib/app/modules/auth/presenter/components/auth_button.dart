import 'package:flutter/material.dart';
import '../../../../../exports_pmsc.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    final state = context.watch<AuthCubit>().state;
    final isLoading = state == AuthState.loading;
    final width = !isLoading ? 0.64 : 0.8;
    return Builder(builder: (context) {
      return state == AuthState.loading
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
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(!isLoading ? 0 : 12))),
              onPressed: () => cubit.auth());
    });
  }
}
