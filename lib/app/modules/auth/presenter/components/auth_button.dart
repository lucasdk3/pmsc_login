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
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state == AuthState.success) {
        AppRouter.instance.to('/base');
      }
    }, builder: (context, state) {
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
                      topLeft: const Radius.circular(12),
                      bottomRight: Radius.circular(!isLoading ? 0 : 12))),
              onPressed: () => cubit.auth());
    });
  }
}
