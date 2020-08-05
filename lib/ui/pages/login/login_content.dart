import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:student_management/ui/pages/login/login_phone.dart';
import 'package:student_management/ui/pages/login/login_user.dart';
import 'package:student_management/ui/shared/animation/flare_animation.dart';
import 'package:student_management/ui/shared/animation/flare_status.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/nav_bar/nav_bar.dart';
import 'package:student_management/core/extension/int_extension.dart';

import 'login_register_forget.dart';

typedef void UpdateFlare(String animation);

class DYXLoginContent extends StatefulWidget {
  @override
  _DYXLoginContentState createState() => _DYXLoginContentState();
}

class _DYXLoginContentState extends State<DYXLoginContent> {
  int _selectedIndex = 0;
  String _flareAnimation = DYXTeddy.test;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.px),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                buildFlare(),
                buildCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// flare 动画
  Widget buildFlare() {
    return DYXFlareAnimation(url: "Teddy",
      animation: _flareAnimation,
      height: 180.px,
    );
  }

  /// 加载flare
  void updateFlare(String animation) {
    setState(() {
      _flareAnimation = animation;
    });
  }

  /// build 登录信息
  Card buildCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.px),
        child: Column(
          children: <Widget>[
            buildBar(),
            buildInfo(),
            buildOther()
          ],
        ),
      ),
    );
  }

  /// 信息
  Widget buildInfo() {
    if(_selectedIndex == 0) return DYXLoginPhone(updateFlare);
    return DYXLoginUser(updateFlare);
  }

  /// 按钮
  Widget buildBar() {
    return DYXNavBar(
      tabs: [
        GButton(
          text: "手机登录",
          icon: DYXIcons.phone,
        ),
        GButton(
          text: "账号登录",
          icon: DYXIcons.user,
        )
      ],
      selectedIndex: _selectedIndex,
      onTabChange: (index) {
        if(_selectedIndex != index) {
          setState(() {
            print("dinaji");
            _selectedIndex = index;
            /// 如果是蒙上眼睛的就放开
            if(_flareAnimation == DYXTeddy.hands_up) {
              _flareAnimation = DYXTeddy.hands_down;
            } else {
              _flareAnimation = DYXTeddy.idle;
            }
          });
        }
      },
    );
  }

  /// 其它信息
  Widget buildOther() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.px),
      child: DYXLoginRegisterForget(),
    );
  }
}
