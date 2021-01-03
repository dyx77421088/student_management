import 'package:flutter/material.dart';
import 'package:student_management/ui/shared/blank_page/blank_page.dart';
/// 班级通知
class DYXClassNoticePage extends StatelessWidget {
  static const String routeName = "/DYXClassNoticePage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("班级通知"),),
      body: DYXBlankPage(),
    );
  }
}
