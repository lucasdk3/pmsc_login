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

  Future off(String pageView, {Object? arguments}) {
    return navigationKey!.currentState!
        .pushReplacementNamed(pageView, arguments: arguments);
  }

  Future to(String routeNamed, {Object? arguments}) {
    return navigationKey!.currentState!
        .pushNamed(routeNamed, arguments: arguments);
  }

  Future navigateToRoute(MaterialPageRoute _rn) {
    return navigationKey!.currentState!.push(_rn);
  }

  Future push(BuildContext context, Widget widget) async {
    return navigationKey!.currentState!
        .push(MaterialPageRoute(builder: (_) => widget));
  }

  Future pushMaterial(BuildContext context, material) async {
    return navigationKey!.currentState!.push(material);
  }

  Future pushAndRelaceToPage(BuildContext context, Widget widget) async {
    return navigationKey!.currentState!
        .pushReplacement(MaterialPageRoute(builder: (_) => widget));
  }

  pop() {
    return navigationKey!.currentState!.pop();
  }
}
