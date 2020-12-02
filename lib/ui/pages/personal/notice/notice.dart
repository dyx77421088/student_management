import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/personal/notice/notice_content.dart';

class DYXNoticePage extends StatefulWidget {
  static const String routeName = "/DYXNoticePage";
  @override
  _DYXNoticePageState createState() => _DYXNoticePageState();
}

class _DYXNoticePageState extends State<DYXNoticePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("发送通知"),),
      body: DYXNoticeContent(),
    );
  }
}
