import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_management/core/extension/int_extension.dart';


/// 安全评分
class DYXShield extends StatelessWidget {
  /// 大小
  final double size;
  /// 分数
  final num fraction;

  DYXShield(this.size, this.fraction):
        assert(size >= 50.px && size <= 200.px),
        assert(fraction >= 0 && fraction <= 100);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
//      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/shield.png"))
      ),
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
//                SizedBox(height: 30.px,),
                Container(
                  padding: EdgeInsets.only(top: size / 5, bottom: size / 20),
                  child: Text('$fraction', style: TextStyle(
                      fontSize: size / 5,
                      color: Color.fromARGB(255, 255, 255, 255)
                  ),),
                ),
//                SizedBox(height: 5.px,),
                Container(
                  padding: EdgeInsets.only(bottom: size / 3),
                  child: Text('账号安全评分', style: TextStyle(
                      fontSize: size / 13,
                      color: Color.fromARGB(255, 255, 255, 255)
                  ),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
