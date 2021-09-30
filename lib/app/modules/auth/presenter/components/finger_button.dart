import 'package:flutter/material.dart';
import '../../../../../exports_pmsc.dart';

class FingerButton extends StatelessWidget {
  const FingerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    final state = context.watch<AuthCubit>().state;
    return Visibility(
      visible: state != AuthState.loading,
      child: MaterialButton(
          height: 46,
          minWidth: MediaQuery.of(context).size.width * 0.12,
          color: Colors.black,
          child: const Icon(
            Icons.fingerprint_outlined,
            color: Colors.white,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(12))),
          onPressed: () => cubit.authWithFinger()),
    );
  }
}
