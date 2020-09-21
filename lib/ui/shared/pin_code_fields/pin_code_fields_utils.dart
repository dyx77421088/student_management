import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';

class DYXPinCodeFieldsUtils {

  static PinCodeTextField buildPinCodeFields({
    Key key,
    StreamController<ErrorAnimationType> errorAnimationController, // 错误信息的控制器
    @required BuildContext context, // 上下文
    @required int length, // code长度
    @required ValueChanged<String> onChanged, // 文本改变之后的回调
    ValueChanged<String> onCompleted, // 完成时的文本回调
    ValueChanged<String> onSubmitted, // 用户从键盘上回车返回的文本回调
    bool obscureText = false, // 模糊文本，也就是密码一样不显示出来
    TextStyle textStyle = const TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ), // 文本的样式，默认为[fontSize:20，颜色： 黑色，字体重量：字体粗体.bold]
    TextStyle pastedTextStyle, // 显示粘贴板中的文字的样式
    DialogConfig dialogConfig, // 粘贴的对话框的样式
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceAround, // 主轴对齐方式
    AnimationType animationType = AnimationType.slide, // 动画类型
    Duration animationDuration = const Duration(milliseconds: 200), // 动画持续时间
    Curve animationCurve = Curves.easeInOut, // 动画的曲线（比如说那种什么快到慢什么的）
    TextInputType keyboardType = TextInputType.number, // 键盘的类型
    bool enabled = false, // 禁用字段 如果为false就不能输入
    PinTheme pinTheme = const PinTheme.defaults(), // 主题
    FormFieldValidator<String> validator, // 检测错误的 验证器
  }) {
    return PinCodeTextField(
      key: key,
      errorAnimationController: errorAnimationController,
      appContext: context,
      length: length,
      onChanged: onChanged,
      onCompleted: onCompleted,
      backgroundColor: DYXColors.blue[50],
      obscureText: obscureText,
      onSubmitted: onSubmitted,
      textStyle: textStyle,
      pastedTextStyle: pastedTextStyle,
      dialogConfig: dialogConfig,
      mainAxisAlignment: mainAxisAlignment,
      animationType: animationType,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      keyboardType: keyboardType,
      enabled: enabled,
      pinTheme: pinTheme,
      validator: validator,
    );
  }
}