import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:google_fonts/google_fonts.dart';
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
        child: Scaffold(
          backgroundColor: background,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Logo(),
                FadingText(
                  'Carregando...',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
                ),
              ],
            ),
          ),
        ));
  }
}
