import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:student_management/core/model/work/work_single.dart';
import 'package:student_management/ui/pages/login/login.dart';
import 'package:student_management/ui/pages/personal/details/details.dart';
import 'package:student_management/ui/pages/personal/details/widget/details_update_personal_signature.dart';
import 'package:student_management/ui/pages/personal/news/class_notice/class_notice.dart';
import 'package:student_management/ui/pages/personal/news/class_work/class_work.dart';
import 'package:student_management/ui/pages/personal/news/news.dart';
import 'package:student_management/ui/pages/personal/news/reply/reply.dart';
import 'package:student_management/ui/pages/personal/news/system_notice/system_notice.dart';
import 'package:student_management/ui/pages/personal/notice/notice.dart';
import 'package:student_management/ui/pages/personal/regular/regular.dart';
import 'package:student_management/ui/pages/personal/regular/regular_add/regular_add.dart';
import 'package:student_management/ui/pages/personal/regular/regular_add/regular_add_record/regular_add_record.dart';
import 'package:student_management/ui/pages/personal/regular/regular_content_edit/regulaar_content_edit.dart';
import 'package:student_management/ui/pages/personal/setting/setting.dart';
import 'package:student_management/ui/pages/personal/setting/user_security_center/user_security_center.dart';
import 'package:student_management/ui/pages/personal/single_work_look/single_work_look.dart';
import 'package:student_management/ui/pages/personal/timetable/time_table.dart';
import 'package:student_management/core/model/regular/regular_search_model.dart' as regular;
import 'package:student_management/core/model/work/work_search.dart' as work;
import 'package:student_management/ui/pages/personal/work/work.dart';
import 'package:student_management/ui/pages/personal/work_look/work_look.dart';
import 'package:student_management/ui/shared/image/image_show.dart';


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
      case DYXRegularAddRecordPage.routeName: // 打卡添加的详细信息
        return PageTransition(
            child: DYXRegularAddRecordPage(settings.arguments as regular.Result),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.topCenter
        );
      case DYXRegularContentEditPage.routeName: // 打卡添加的详细信息
        return PageTransition(
            child: DYXRegularContentEditPage(settings.arguments as DYXRegularContentEditSetting),
            type: PageTransitionType.scale,
            alignment: Alignment.center
        );
      case DYXImageShowPage.routeName: // 图片显示的效果
        return PageTransition(
            child: DYXImageShowPage(settings.arguments as ImageProvider),
            type: PageTransitionType.fade,
            alignment: Alignment.topCenter
        );
      case DYXNoticePage.routeName: // 通知显示的效果
        return PageTransition(
            child: DYXNoticePage(),
            type: PageTransitionType.scale,
            alignment: Alignment.center
        );
      case DYXWorkPage.routeName: // 作业显示的效果
        return PageTransition(
            child: DYXWorkPage(),
            type: PageTransitionType.scale,
            alignment: Alignment.center
        );
      case DYXWorkPage.routeNameUpdate: // 作业修改的效果
        return PageTransition(
            child: DYXWorkPage(work: settings.arguments as DYXWorkSingleModel,),
            type: PageTransitionType.scale,
            alignment: Alignment.center
        );
      case DYXWorkLookPage.routeName: // 作业查看的效果
        return PageTransition(
            child: DYXWorkLookPage(),
            type: PageTransitionType.scale,
            alignment: Alignment.center
        );
      case DYXNewsPage.routeName: // 消息显示的效果
        return PageTransition(
            //暂时先显示工作的work
            child: DYXClassWorkPage(),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.center
        );
      case DYXReplyPage.routeName: // 回复消息的显示的效果
        return PageTransition(
            child: DYXReplyPage(),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.center
        );
      case DYXClassNoticePage.routeName: // 班级通知的显示的效果
        return PageTransition(
            child: DYXClassNoticePage(),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.center
        );
      case DYXClassWorkPage.routeName: // 班级作业的显示的效果
        return PageTransition(
            child: DYXClassWorkPage(),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.center
        );
      case DYXSystemNoticePage.routeName: // 系统通知的显示的效果
        return PageTransition(
            child: DYXSystemNoticePage(),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.center
        );
      case DYXSingleWorkLookPage.routeName: // 单个work查看
        return PageTransition(
            child: DYXSingleWorkLookPage(settings.arguments as DYXWorkSingleModel, canUpdate: false,),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.center
        );
      case DYXSingleWorkLookPage.routeNameCanUpdate: // 单个work查看, 并能修改
        return PageTransition(
            child: DYXSingleWorkLookPage(settings.arguments as DYXWorkSingleModel, canUpdate: true),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.center
        );
      default:
        return null;
    }
  };

  static final RouteFactory onUnknownRoute = (setting) {
    return null;
  };
}