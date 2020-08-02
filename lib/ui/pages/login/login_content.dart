import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/login/login_phone.dart';
import 'package:student_management/ui/pages/login/login_user.dart';

class DYXLoginContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        DYXLoginPhone(),
        DYXLoginUser(),
      ],
    );
  }
}
