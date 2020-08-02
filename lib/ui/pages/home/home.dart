import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_content.dart';

class DYXHomePage extends StatefulWidget {
  static const String routeName = "/home";

  @override
  _DYXHomePageState createState() => _DYXHomePageState();
}

class _DYXHomePageState extends State<DYXHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        leading: IconButton(
          icon: CircleAvatar(
            backgroundImage: AssetImage("assets/images/xzdl.png"),
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: DYXHomeContent(),
    );
  }
}
