import 'package:flutter/material.dart';

class DYXRegisterPage extends StatelessWidget {
  static const String routeName = "/register";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('注册'),),
      body: Center(
        child: Text('注册'),
      ),
    );
  }
}
