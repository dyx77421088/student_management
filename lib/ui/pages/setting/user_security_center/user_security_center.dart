import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/setting/user_security_center/user_security_center_content.dart';

class DYXUserSecurityCenterPage extends StatelessWidget {
  static const String routeName = "/userSecurityCenter";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户安全中心'),
      ),
      body: DYXUserSecurityCenterContent(),
    );
  }
}
