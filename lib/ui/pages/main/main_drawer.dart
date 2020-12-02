import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/core/router/route_animation.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/pages/login/login.dart';
import 'package:student_management/ui/pages/personal/details/details.dart';
import 'package:student_management/ui/pages/personal/news/news.dart';
import 'package:student_management/ui/shared/dialog/dialog.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/image/image_network.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';
import 'package:student_management/ui/shared/toast/toast.dart';

class DYXMainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Material(
        color: Colors.transparent,
        child: Consumer<DYXUserViewModel>(
          builder: (ctx, userVM, child)=>Column(
            children: [
              buildHeaderView(context, userVM),
              buildNews(context, userVM),
              buildExit(context, userVM),
            ],
          ),
        ),
      );
  }

  /// 新的消息
  buildNews(BuildContext context, userVM) => buildListTile(
      context,
      Icon(DYXIcons.wallet),
      "消息",
      () {
        Navigator.pushNamed(context, DYXNewsPage.routeName);
      }
  );

  /// 退出
  Widget buildExit(BuildContext context, DYXUserViewModel userVM) {
    return buildListTile(context, Icon(DYXIcons.logout), "注销",() {
      if(userVM.isLogin) {
        DYXDialog.showDialog(
          context: context,
          title: "退出",
          desc: "是否退出?",
          btnOkOnPress: () {
            userVM.logOut();
            DYXToast.showToast("成功退出用户!");
            Navigator.of(context).pop();
          },
          btnCancelOnPress: () {},
        );
      } else {
        DYXDialog.showDialog(
          context: context,
          title: "请先登录",
          btnOkOnPress: () {
            Navigator.pushNamed(context, DYXLoginPage.routeName);
          }
        );
      }

    });
  }

  /// 头部
  Widget buildHeaderView(BuildContext context, DYXUserViewModel userVM) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Colors.transparent,
//        borderRadius: BorderRadius.circular(30.px)
      ),
      margin: EdgeInsets.only(bottom: 20.px),
      currentAccountPicture: buildAvatar(context),
      accountName: Text(userVM.name ?? "请先登录"),
      accountEmail: Text(userVM.schoolName ?? ""),
      otherAccountsPictures: <Widget>[

        Text(userVM.className ?? "")
      ],
    );
  }

  /// 头像
  Widget buildAvatar(BuildContext context) {
    return Consumer<DYXUserViewModel>(
      builder: (ctx, userVM, child) => GestureDetector(
          child: buildAvatarImg(userVM),
          onTap: () => checkAvatar(context, userVM),
        ),
    );
  }

  /// 头像
  Widget buildAvatarImg(DYXUserViewModel userVM) {
    if (userVM.avatar != null) {
      return DYXImageNetwork.avatarNetwork(url: userVM.avatar);
    }
    return CircleAvatar(
      backgroundImage: AssetImage("assets/images/avatar_unlogin.png"),
      backgroundColor: Colors.white,
    );
  }

  /// 单击头像
  void checkAvatar(BuildContext context, DYXUserViewModel userVM) {
    if(userVM.isLogin) {
      Navigator.pushNamed(context, DYXDetailsPage.routeName);
    } else {
      Navigator.pushNamed(context, DYXLoginPage.routeName);
    }
  }

  Widget buildListTile(BuildContext context, Widget icon, String title, Function onTap) {
    return ListTile(
      leading: icon,
      title: Text(title, style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),),
      onTap: onTap,
    );
  }
}
