import 'package:flutter/material.dart';
import '../../../../../exports_pmsc.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    final state = context.watch<AuthCubit>().state;
    return Builder(builder: (context) {
      return state == AuthState.loading
          ? const Center(child: CircularProgressIndicator())
          : ElevatedButton(
              onPressed: () => cubit.auth(), child: const Text('logar'));
    });
  }
}
