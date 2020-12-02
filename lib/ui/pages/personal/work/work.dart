import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/personal/work/work_content.dart';

class DYXWorkPage extends StatelessWidget {
  static const String routeName = "/DYXWorkPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("作业"),),
      body: DYXWorkContent(),
    );
  }
}
