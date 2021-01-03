import 'package:flutter/material.dart';
import 'package:student_management/ui/shared/blank_page/blank_page.dart';
/// 回复页面
class DYXReplyPage extends StatelessWidget {
  static const String routeName = "/DYXReplyPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("回复"),),
      body: DYXBlankPage(
        imageType: DYXBlankType.tuzi,
      ),
    );
  }
}
