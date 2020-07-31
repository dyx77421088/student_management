import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/setting/setting_content.dart';

class DYXSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('设置'),),
      body: DYXSettingContent(),
    );
  }
}
