import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/login/login_appbar.dart';
import 'package:student_management/ui/pages/login/login_content.dart';
import 'package:student_management/ui/shared/animation/flare_animation.dart';
import 'package:student_management/ui/shared/animation/flare_status.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';
import 'package:student_management/core/extension/int_extension.dart';

class DYXLoginPage extends StatefulWidget {
  static const String routeName = "/login";

  @override
  _DYXLoginPageState createState() => _DYXLoginPageState();
}

class _DYXLoginPageState extends State<DYXLoginPage> with SingleTickerProviderStateMixin{
  List<String> anim = [
    DYXBackgroundHomeIverusOld.island01,
    DYXBackgroundHomeIverusOld.island02,
    DYXBackgroundHomeIverusOld.island03,
    DYXBackgroundHomeIverusOld.island04,
    DYXBackgroundHomeIverusOld.island05,
    DYXBackgroundHomeIverusOld.island06,
  ];
  int index = 0;
  Timer timer;

  @override
  void initState() {
     timer = Timer.periodic(Duration(seconds: 20), (timer) {
      setState(() {
        index = (index + 1) % anim.length;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: DYXLoginAppBar(context),
      body: Container(
//        color: Colors.red,
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(height: double.infinity,child: buildFlareBg()),
            DYXLoginContent(),
            Positioned(
              top: 10.px,
              left: 10.px,
              child: IconButton(
                icon: Icon(Icons.close, size: 40.px,),
                color: DYXColors.blue[300],
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 背景动画
  Widget buildFlareBg(){
    FlareActor flareActor = FlareActor("assets/flr/${DYXBackgroundHomeIverusOld.name}.flr",
        alignment:Alignment.center,
        fit:BoxFit.fill,
        animation:anim[index],
        callback: (value) {
          print("输出了$value");
        },
    );
    return flareActor;
  }
}
