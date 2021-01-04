import 'package:flutter/material.dart';
import 'package:student_management/ui/shared/blank_page/blank_page.dart';

class DYXSystemNoticePage extends StatelessWidget {
  static const routeName = "/DYXSystemNoticePage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("系统消息"),),
      body: DYXBlankPage(
        imageType: DYXBlankType.tuzi,
      ),
    );
  }
}
