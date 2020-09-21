import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/personal/timetable/time_table_content.dart';

class DYXTimeTablePage extends StatelessWidget {
  static const String routeName = "/DYXTimeTablePage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('课表'),),
      body: DYXTimeTableContent(),
    );
  }
}
