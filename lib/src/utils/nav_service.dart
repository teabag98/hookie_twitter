import 'package:flutter/material.dart';

class NavigatorService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> pushNamed(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  void pop({bool leave}) {
    return navigatorKey.currentState.pop(leave ?? true);
  }

  BuildContext context() {
    return navigatorKey.currentContext;
  }

  Future<dynamic> pushReplacementNamed(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName, String until,
      {Map arguments}) {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
        routeName, ModalRoute.withName(until),
        arguments: arguments);
  }

  String currentRoute() {
    return ModalRoute.of(context()).settings.name;
  }

  void popUntil(String until) {
    return navigatorKey.currentState.popUntil(ModalRoute.withName(until));
  }
}
