import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/personal/work_look/work_look_content.dart';

class DYXWorkLookPage extends StatefulWidget {
  static const String routeName = "/DYXWorkLookPage";

  @override
  _DYXWorkLookPageState createState() => _DYXWorkLookPageState();
}

class _DYXWorkLookPageState extends State<DYXWorkLookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我发布的作业"),
      ),
      body: DYXWorkLookContent(),
    );
  }

}
