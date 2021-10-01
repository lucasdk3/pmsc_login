import 'package:flutter/material.dart';

import '../../../../../exports_pmsc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state == SplashState.success) {
            AppRouter.instance.to('/base');
          } else if (state == SplashState.error) {
            AppRouter.instance.to('/auth');
          } else {
            null;
          }
        },
        child: Container());
  }
}
