import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/login/login_appbar.dart';
import 'package:student_management/ui/pages/login/login_content.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';

class DYXLoginPage extends StatelessWidget {
  static const String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DYXLoginAppBar(context),
      body: DYXLoginContent(),
    );
  }
}
