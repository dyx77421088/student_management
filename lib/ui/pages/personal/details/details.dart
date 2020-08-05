import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/personal/details/details_content.dart';

class DYXDetailsPage extends StatelessWidget {
  static const String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('修改信息'),),
      body: DYXDetailsContent(),
    );
  }
}
