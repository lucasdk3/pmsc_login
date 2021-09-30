import 'package:flutter/material.dart';
import '../exports_pmsc.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MaterialApp(
          title: 'PMSC Chat',
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          navigatorKey: AppRouter.instance.navigationKey,
          routes: AppRouter.routes,
        );
      },
    );
  }
}
