import 'package:flutter/material.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';

class DYXLoginAppBar extends AppBar {
  DYXLoginAppBar(context) : super(
    leading: IconButton(icon: Icon(Icons.close), color: DYXColors.blue[300], onPressed: () => Navigator.pop(context),),
    backgroundColor: DYXColors.blue[50],
//    bottom: TabBar(
//      indicatorColor: Colors.red,
//      unselectedLabelColor: Colors.grey,
//      labelColor: Colors.red,
//      tabs: <Widget>[
//        Tab(text: "手机号登录",),
//        Tab(text: "账号登陆",),
//      ],
//    )
  );
}