import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/core/router/route_animation.dart';
import 'package:student_management/core/viewmodel/user_view_model.dart';
import 'package:student_management/ui/pages/login/login.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/image/image_network.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';
import 'package:student_management/ui/shared/toast/toast.dart';

class DYXMainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.px,
      child: Drawer(
        child: Consumer<DYXUserViewModel>(
          builder: (ctx, userVM, child) => ListView(
            children: <Widget>[
              buildHeaderView(context, userVM),
              buildListTile(context, Icon(DYXIcons.logout), "注销",() {
                userVM.logOut();
                DYXToast.showToast("成功退出用户!");
                Navigator.of(context).pop();
              }),
            ],
          ),
        ),
      ),
    );
  }

  /// 头部
  Widget buildHeaderView(BuildContext context, DYXUserViewModel userVM) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: DYXColors.blue[200],
//        borderRadius: BorderRadius.circular(30.px)
      ),
      margin: EdgeInsets.only(bottom: 20.px),
      currentAccountPicture: buildAvatar(context),
      accountName: Text(userVM.name != null ? userVM.name : "???"),
      accountEmail: Text(userVM.school != null ? userVM.school : ""),
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
      DYXToast.showToast("已经登陆了");
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
