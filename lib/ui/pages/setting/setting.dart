import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/setting/setting_content.dart';

class DYXSettingPage extends StatelessWidget {
  static const String routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('设置'),),
//      body: DYXSettingContent(),
      bottomSheet: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: RaisedButton(child: Text('退出登录', style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white),), onPressed: (){}, color: Color.fromRGBO(157,41,51, 1),)
      ),
    );
  }
}
