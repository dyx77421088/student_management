import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:student_management/core/router/route_animation.dart';
import 'package:student_management/ui/pages/login/login.dart';
import 'package:student_management/ui/pages/personal/details/details.dart';
import 'package:student_management/ui/pages/personal/details/widget/details_update_personal_signature.dart';
import 'package:student_management/ui/pages/personal/regular/regular.dart';
import 'file:///D:/flutterDemo/student_management/lib/ui/pages/personal/regular/regular_add/regular_add.dart';
import 'package:student_management/ui/pages/personal/setting/setting.dart';
import 'package:student_management/ui/pages/personal/setting/user_security_center/user_security_center.dart';
import 'package:student_management/ui/pages/personal/timetable/time_table.dart';
import 'package:student_management/ui/shared/phone_verification/phone_verification.dart';

class DYXRouter {
  static final Map<String, WidgetBuilder> routes = {
  };

  static final String initialRoute = "/";

  static final RouteFactory onGenerateRoute = (settings) {
    switch (settings.name) {
      case DYXLoginPage.routeName:// 登录路由
        return PageTransition(
            child: DYXLoginPage(),
            type: PageTransitionType.scale
        );
        break;
      case DYXDetailsPage.routeName:// 用户详情的路由
        return PageTransition(
          child: DYXDetailsPage(),
          type: PageTransitionType.fade,
          alignment: Alignment.topCenter,
        );
        break;
      case DYXSettingPage.routeName:// 设置
        return PageTransition(
            child: DYXSettingPage(),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.bottomCenter
        );
        break;
      case DYXDetailsUpdatePersonalSignaturePage.routeName: // 修改用户详情的签名
        return PageTransition(
            child: DYXDetailsUpdatePersonalSignaturePage(settings.arguments as String),
            type: PageTransitionType.fade,
            alignment: Alignment.topCenter,
        );
      case DYXUserSecurityCenterPage.routeName: // 用户安全中心
        return PageTransition(
            child: DYXUserSecurityCenterPage(),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.topCenter
        );
      case DYXTimeTablePage.routeName: // 课表
        return PageTransition(
            child: DYXTimeTablePage(),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.topCenter
        );
      case DYXRegularPage.routeName: // 打卡
        return PageTransition(
            child: DYXRegularPage(),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.topCenter
        );
      case DYXRegularAddPage.routeName: // 打卡添加
        return PageTransition(
            child: DYXRegularAddPage(),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.topCenter
        );
      default:
        return null;
    }
  };

  static final RouteFactory onUnknownRoute = (setting) {
    return null;
  };
}