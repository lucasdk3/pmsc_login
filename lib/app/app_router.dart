import 'package:flutter/material.dart';
import 'package:pmsc_auth/app/_exports.dart';

class Route {
  final String pageView;
  final Object? arguments;

  Route(this.pageView, this.arguments);
}

class AppRouter {
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
    '/': (BuildContext context) => const SplashPage(),
    '/auth': (BuildContext context) => const AuthPage(),
    '/base': (BuildContext context) => const BasePage(),
  };

  GlobalKey<NavigatorState>? navigationKey;

  static AppRouter instance = AppRouter();

  AppRouter() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic> off(String _rn) {
    return navigationKey!.currentState!.pushReplacementNamed(_rn);
  }

  Future<dynamic> to(String _rn) {
    return navigationKey!.currentState!.pushNamed(_rn);
  }

  Future<dynamic> navigateToRoute(MaterialPageRoute _rn) {
    return navigationKey!.currentState!.push(_rn);
  }

  pop() {
    return navigationKey!.currentState!.pop();
  }
}
