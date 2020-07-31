import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/home/home.dart';
import 'package:student_management/ui/pages/setting/setting.dart';

final List<Widget> pages = [
  DYXHomePage(),
  DYXSettingPage()
];

final List<BottomNavigationBarItem> items = [
  BottomNavigationBarItem(
    title: Text("首页"),
    icon: Icon(Icons.home)
  ),
  BottomNavigationBarItem(
      title: Text("设置"),
      icon: Icon(Icons.settings)
  )
];