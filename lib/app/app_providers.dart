import 'package:flutter/material.dart';
import '../exports_pmsc.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: buildProviders(),
      child: const AppWidget(),
    );
  }
}

List<BlocProvider> buildProviders() => [
      BlocProvider(
          create: (BuildContext context) =>
              SplashCubit(context.read())..verifyAuth()),
      BlocProvider(
          create: (BuildContext context) =>
              AuthCubit(context.read(), context.read(), context.read()))
    ];
