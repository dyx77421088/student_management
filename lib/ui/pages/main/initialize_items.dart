import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:student_management/ui/pages/home/home.dart';
import 'package:student_management/ui/pages/page1/page1.dart';
import 'package:student_management/ui/pages/page2/page2.dart';
import 'package:student_management/ui/pages/personal/personal.dart';
import 'package:student_management/ui/pages/setting/setting.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';

final List<Widget> pages = [
  DYXHomePage(),
  DYXPage1(),
  DYXPage2(),
  DYXPersonalPage(),
];

final List<GButton> items = [
  GButton(
    text: "首页",
    icon: DYXIcons.home,
    backgroundColor: DYXColors.navBar[100],
  ),
  GButton(
    text: "发现",
    icon: DYXIcons.search,
    backgroundColor: DYXColors.navBar[200],
  ),
  GButton(
    text: "未知",
    icon: Icons.home,
    backgroundColor: DYXColors.navBar[300],
  ),
  GButton(
    text: "个人中心",
    icon: DYXIcons.user,
    backgroundColor: DYXColors.navBar[400],
  ),
];