import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/personal/personal_content.dart';

class DYXPersonalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('个人中心'),),
      body: DYXPersonalContent(),
    );
  }
}
