import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class DYXDialog {
  /// 展示对话框
  static Future showDialog({
    @required BuildContext context,
    bool headerAnimationLoop = false,// 头部动画循环
    DialogType dialogType = DialogType.INFO,// 头部类型,默认为info
    String title = "", // 标题
    String desc = "", // 描述
    Function btnCancelOnPress, // 点击取消按钮的监听
    String btnCancelText = "取消", // 取消按钮的文字
    Color btnCancelColor, // 取消按钮的颜色
    Function btnOkOnPress, // ok按钮的监听
    String btnOkText = "确定", // ok按钮的文字
    Color btnOkColor, // ok按钮的颜色
    bool dismissOnTouchOutside = true, // 触摸空白区域关闭对话框
    bool dismissOnBackKeyPress = true, // 按回退建关闭对话框
    Duration autoHide, // 过了时间后自动隐藏
    Widget body, // 主体
    Alignment alignment = Alignment.center, // 对齐方式
    AnimType animType = AnimType.SCALE, // 动画
    bool useRootNavigator = false, //使用根导航器而不是本地导航器。当默认取消取消转到上一个屏幕而不是仅关闭对话框时，此功能很有用
    Function onDissmissCallback
  })async{
    return AwesomeDialog(
      context: context,
      headerAnimationLoop: headerAnimationLoop,
      dialogType: dialogType,
      title: title,
      desc: desc,
      btnCancelOnPress: btnCancelOnPress,
      btnCancelText: btnCancelText,
      btnCancelColor: btnCancelColor,
      btnOkOnPress: btnOkOnPress,
      btnOkText: btnOkText,
      btnOkColor: btnOkColor,
      dismissOnTouchOutside: dismissOnTouchOutside,
      dismissOnBackKeyPress: dismissOnBackKeyPress,
      autoHide: autoHide,
      body: body,
      aligment: alignment,
      animType: animType,
      useRootNavigator: useRootNavigator,
      onDissmissCallback: onDissmissCallback,
    )..show();
  }

  /// 按钮，点击后出现对话框
  static Widget dialogButton({
    @required BuildContext context,
    String buttonText, // 按钮文字
    Color buttonColor, // 按钮颜色
    double buttonWidth, // 按钮宽度
    bool headerAnimationLoop = false,// 头部动画循环
    DialogType dialogType = DialogType.INFO,// 头部类型,默认为无头部
    String title = "", // 标题
    String desc = "", // 描述
    Function btnCancelOnPress, // 点击取消按钮的监听
    String btnCancelText = "取消", // 取消按钮的文字
    Color btnCancelColor, // 取消按钮的颜色
    Function btnOkOnPress, // ok按钮的监听
    String btnOkText = "确定", // ok按钮的文字
    Color btnOkColor, // ok按钮的颜色
    bool dismissOnTouchOutside = true, // 触摸空白区域关闭对话框
    bool dismissOnBackKeyPress = true, // 按回退建关闭对话框
    Duration autoHide, // 过了时间后自动隐藏
    Widget body, // 主体
    Alignment alignment = Alignment.center, // 对齐方式
    AnimType animType = AnimType.SCALE, // 动画
  }) {
    return AnimatedButton(
      text: buttonText,
      color: buttonColor,
      width: buttonWidth,
      pressEvent: () {
        showDialog(
          context: context,
          headerAnimationLoop: headerAnimationLoop,
          dialogType: dialogType,
          title: title,
          desc: desc,
          btnCancelOnPress: btnCancelOnPress,
          btnCancelText: btnCancelText,
          btnCancelColor: btnCancelColor,
          btnOkOnPress: btnOkOnPress,
          btnOkText: btnOkText,
          btnOkColor: btnOkColor,
          dismissOnTouchOutside: dismissOnTouchOutside,
          dismissOnBackKeyPress: dismissOnBackKeyPress,
          autoHide: autoHide,
          body: body,
          alignment: alignment,
          animType: animType
        );
      },
    );
  }
}