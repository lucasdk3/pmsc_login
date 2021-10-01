import 'package:flutter/material.dart';
import '../exports_pmsc.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashCubit(context.read())..init()),
        BlocProvider(create: (context) => AuthCubit())
      ],
      child: const AppWidget(),
    );
  }
}
