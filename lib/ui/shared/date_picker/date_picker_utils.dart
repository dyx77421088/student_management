import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter/material.dart';

typedef DateValueCallback(DateTime dateTime, List<int> selectedIndex);
class DYXDatePickerUtils {
  /// 显示BottomSheet形式的日期时间选择器。
  ///
  /// context: [BuildContext]
  /// minDateTime: [DateTime] 日期选择器的最小值
  /// maxDateTime: [DateTime] 日期选择器的最大值
  /// initialDateTime: [DateTime] 日期选择器的初始值
  /// dateFormat: [String] 日期时间格式化
  /// locale: [DateTimePickerLocale] 国际化，语言地区
  /// pickerMode: [DateTimePickerMode] 显示的类型: date(日期选择器)、time(时间选择器)、datetime(日期时间选择器)
  /// pickerTheme: [DateTimePickerTheme] 日期选择器的样式
  /// onCancel: [DateVoidCallback] 点击标题取消按钮的回调事件
  /// onClose: [DateVoidCallback] 关闭日期时间选择器的回调事件
  /// onChange: [DateValueCallback] 选择的日期时间改变的事件
  /// onConfirm: [DateValueCallback] 点击标题确定按钮的回调事件
  static void showTime({
    @required BuildContext context,
    DateTime minDateTime,
    DateTime maxDateTime,
    DateTime initialDateTime,
    DateValueCallback onConfirm,
    String dateFormat,
    DateTimePickerLocale locale = DateTimePickerLocale.zh_cn
  }) {
    DatePicker.showDatePicker(
      context,
      locale: locale,
      minDateTime: minDateTime,
      maxDateTime: maxDateTime,
      initialDateTime: initialDateTime,
      onConfirm: onConfirm,
      dateFormat: dateFormat,
    );
  }


}