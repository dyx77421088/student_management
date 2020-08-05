import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:student_management/core/router/route_animation.dart';
import 'package:student_management/ui/pages/login/login.dart';
import 'package:student_management/ui/pages/personal/details/details.dart';
import 'package:student_management/ui/pages/setting/setting.dart';

class DYXRouter {
  static final Map<String, WidgetBuilder> routes = {
  };

  static final String initialRoute = "/";

  static final RouteFactory onGenerateRoute = (settings) {
    switch (settings.name) {
      // 登录路由
      case DYXLoginPage.routeName:
        return PageTransition(
            child: DYXLoginPage(),
            type: PageTransitionType.scale
        );
        break;
      // 用户详情的路由
      case DYXDetailsPage.routeName:
        return PageTransition(
            child: DYXDetailsPage(),
            type: PageTransitionType.rotate,
            alignment: Alignment.topCenter
        );
        break;
      case DYXSettingPage.routeName:
        return PageTransition(
            child: DYXSettingPage(),
            type: PageTransitionType.upToDown,
            alignment: Alignment.topCenter
        );
        break;
      default:
        return null;
    }
  };

  static final RouteFactory onUnknownRoute = (setting) {
    return null;
  };
}