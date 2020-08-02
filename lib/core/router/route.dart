import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/login/login.dart';

class DYXRouter {
  static final Map<String, WidgetBuilder> routes = {
    DYXLoginPage.routeName : (ctx) => DYXLoginPage(),
  };

  static final String initialRoute = "/";

  static final RouteFactory onGenerateRoute = (setting) {
    return null;
  };

  static final RouteFactory onUnknownRoute = (setting) {
    return null;
  };
}