import 'package:flutter/material.dart';
import 'package:student_management/ui/shared/blank_page/blank_page.dart';

class DYXClassWorkPage extends StatelessWidget {
  static const routeName = "/DYXClassWorkPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("班级作业"),),
      body: DYXBlankPage(),
    );
  }
}
