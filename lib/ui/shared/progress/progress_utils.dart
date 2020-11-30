import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:student_management/ui/shared/dialog/dialog.dart';
import 'package:student_management/core/extension/int_extension.dart';

/// 进度条类型
enum DYXProgressType {
  boat, // 小船
  speechBubble, // 会话框
  heart, // 心
}
class DYXProgress extends StatefulWidget {
  final DYXProgressType type;

  DYXProgress(this.type);

  @override
  _DYXProgressState createState() => _DYXProgressState();
}

class _DYXProgressState extends State<DYXProgress> {
  @override
  Widget build(BuildContext context) {
    return LiquidCustomProgressIndicator(
      direction: Axis.vertical,
      value: 0.2,
      shapePath: _switchPath(widget.type),
    );
  }

  /// 选择路径
  Path _switchPath(DYXProgressType type) {
    switch(type) {
      case DYXProgressType.boat: return _buildBoatPath();
      case DYXProgressType.heart: return _buildHeartPath();
      case DYXProgressType.speechBubble: return _buildSpeechBubblePath();
    }
    return null;
  }

  /// 小船
  Path _buildBoatPath() {
    return Path()
      ..moveTo(15, 120)
      ..lineTo(0, 85)
      ..lineTo(50, 85)
      ..lineTo(50, 0)
      ..lineTo(105, 80)
      ..lineTo(60, 80)
      ..lineTo(60, 85)
      ..lineTo(120, 85)
      ..lineTo(105, 120)
      ..close();
  }

  /// 会话框
  Path _buildSpeechBubblePath() {
    return Path()
      ..moveTo(50, 0)
      ..quadraticBezierTo(0, 0, 0, 37.5)
      ..quadraticBezierTo(0, 75, 25, 75)
      ..quadraticBezierTo(25, 95, 5, 95)
      ..quadraticBezierTo(35, 95, 40, 75)
      ..quadraticBezierTo(100, 75, 100, 37.5)
      ..quadraticBezierTo(100, 0, 50, 0)
      ..close();
  }

  /// 心
  Path _buildHeartPath() {
    return Path()
      ..moveTo(55, 15)
      ..cubicTo(55, 12, 50, 0, 30, 0)
      ..cubicTo(0, 0, 0, 37.5, 0, 37.5)
      ..cubicTo(0, 55, 20, 77, 55, 95)
      ..cubicTo(90, 77, 110, 55, 110, 37.5)
      ..cubicTo(110, 37.5, 110, 0, 80, 0)
      ..cubicTo(65, 0, 55, 12, 55, 15)
      ..close();
  }
}

/// 进度对话框
class DYXProgressDialog {
  static AwesomeDialog showProgressDialog({
    @required BuildContext context,
    DYXProgressType type = DYXProgressType.boat, // 类型
    String message = "努力加载中",
  }) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      // dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      body: Column(
        children: [
          DYXProgress(type),
          SizedBox(height: 10.px,),
          Text(message)
        ],
      )
    );
  }
  static Widget progressDialog({
    @required BuildContext context,
    DYXProgressType type = DYXProgressType.boat, // 类型
    String message = "努力加载中",
  }) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: SizedBox(
          height: 200.0,
          width: 300.0,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: DYXProgress(type),
                ),
                Container(
                  child: Text(message),
                )
              ],
            ),
          ),
        )),
    );
  }
}

