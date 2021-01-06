import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/router/route_animation.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/pages/login/login.dart';
import 'package:student_management/ui/pages/personal/details/details.dart';
import 'package:student_management/ui/pages/personal/news/news.dart';
import 'package:student_management/ui/pages/personal/notice/notice.dart';
import 'package:student_management/ui/pages/personal/regular/regular.dart';
import 'package:student_management/ui/pages/personal/timetable/time_table.dart';
import 'package:student_management/ui/pages/personal/work/work.dart';
import 'package:student_management/ui/pages/personal/work_look/work_look.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/image/image_network.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/ui/widgets/setting_item.dart';

import 'setting/setting.dart';

class DYXPersonalContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.px),
      child: buildInfo(context),
    );
  }

  Widget buildInfo(BuildContext context) {
    return Consumer<DYXUserViewModel>(
      builder: (ctx, userVM, child) => ListView(
        children: <Widget>[
           buildHead(context,
              userVM.isLogin ? (userVM.name ?? "未知") : ("请先登录"),
              buildAvatarImg(userVM),
              onPressed: () {
                if(userVM.isLogin) {
                  Navigator.pushNamed(context, DYXDetailsPage.routeName);
                } else {
                  Navigator.pushNamed(context, DYXLoginPage.routeName);
                }
              }
          ),
          SizedBox(height: 10.px,),
          userVM.dyxRole != DYXRole.student ? SizedBox() : DYXSettingItem(
              title: "课表",
              leading:  Icon(DYXIcons.calendar, color: DYXColors.navBar[50],),
              onPressed: () {
                userVM.isLogin ? Navigator.pushNamed(context, DYXTimeTablePage.routeName) :
                Navigator.pushNamed(context, DYXLoginPage.routeName);
              }
          ),
          // DYXSettingItem(
          //     title: "课程",
          //     leading:  Icon(DYXIcons.graduation, color: DYXColors.navBar[50],),
          //     onPressed: () {}
          // ),
          // DYXSettingItem(
          //     title: "作业",
          //     leading:  Icon(DYXIcons.pencil, color: DYXColors.navBar[800],),
          //     onPressed: () {}
          // ),
          // DYXSettingItem(
          //     title: "考试",
          //     leading:  Icon(DYXIcons.exam, color: DYXColors.navBar[700],),
          //     onPressed: () {}
          // ),
          // DYXSettingItem(
          //     title: "打卡",
          //     leading:  Icon(DYXIcons.fingerprint, color: DYXColors.navBar[700],),
          //     onPressed: () {
          //       if(DYXUserViewModel.staticToken != null)
          //         Navigator.pushNamed(context, DYXRegularPage.routeName);
          //       else
          //         Navigator.pushNamed(context, DYXLoginPage.routeName);
          //     }
          // ),
          SizedBox(height: 10.px),
          DYXSettingItem(
            title: "消息",
            leading:  Icon(DYXIcons.news, color: DYXColors.navBar[100],),
            onPressed: () {
              userVM.isLogin ? Navigator.pushNamed(context, DYXNewsPage.routeName) :
              Navigator.pushNamed(context, DYXLoginPage.routeName);
            }
          ),
          // userVM.dyxRole == DYXRole.teacher || userVM.dyxRole == DYXRole.instructor ? DYXSettingItem(
          //     title: "发布通知",
          //     leading:  Icon(DYXIcons.notification, color: DYXColors.navBar[300],),
          //     onPressed: () {
          //       Navigator.pushNamed(context, DYXNoticePage.routeName);
          //     }
          // ):SizedBox(),
          userVM.dyxRole == DYXRole.teacher || userVM.dyxRole == DYXRole.instructor ? DYXSettingItem(
              title: "发布作业",
              leading:  Icon(DYXIcons.book, color: DYXColors.navBar[400],),
              onPressed: () {
                Navigator.pushNamed(context, DYXWorkPage.routeName);
              }
          ):SizedBox(),
          userVM.dyxRole == DYXRole.instructor ? DYXSettingItem(
              title: "班级发布的通知",
              leading:  Icon(DYXIcons.cloud, color: DYXColors.navBar[400],),
              onPressed: () {
                Navigator.pushNamed(context, DYXWorkLookPage.routeName);
              }
          ):SizedBox(),
          // DYXSettingItem(
          //     title: "钱包",
          //     leading:  Icon(DYXIcons.wallet, color: DYXColors.navBar[500],),
          //     onPressed: () {}
          // ),
          SizedBox(height: 10.px),
          DYXSettingItem(
              title: "设置",
              leading:  Icon(DYXIcons.settings, color: DYXColors.navBar[600],),
              onPressed: () {
                Navigator.pushNamed(context, DYXSettingPage.routeName);
              }
          ),
        ],
      )
    );
  }

  /// 头像
  Widget buildAvatarImg(DYXUserViewModel userVM) {
    if (userVM.avatar != null) {
      return DYXImageNetwork.avatarNetwork(url: userVM.avatar);
    }
    return CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage("assets/images/avatar_unlogin.png"),
      backgroundColor: Colors.white,
    );
  }

  /// 头部
  Widget buildHead(BuildContext context, String title, Widget leading,
      {@required onPressed}) {
    return Container(
      height: 100.px,
      child: RaisedButton(
          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
          color: Theme.of(context).dialogBackgroundColor,
          child: Row(
              children: <Widget>[
                Container(width: 60.px, height : 60.px, child: leading,),
                SizedBox(width: 10.px,),
                Expanded(child: Text(title, style: Theme.of(context).textTheme.subtitle1,)),
                Icon(Icons.chevron_right)
              ],
            ),
          onPressed: onPressed),
    );
  }
}
