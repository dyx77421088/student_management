import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/personal/news/news_content.dart';

class DYXNewsPage extends StatelessWidget {
  static const String routeName = "/DYXNewsPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("消息"),),
      body: DYXNewContent(),
    );
  }
}
