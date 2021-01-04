import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:student_management/ui/shared/toast/toast.dart';

//import 'date_picker_bottom_sheet.dart';

//import './date_picker_in.dart';
//import './datetime_picker_bottom_sheet.dart';
//import './datetime_picker_in_page.dart';
//import './time_picker_bottom_sheet.dart';
//import './time_picker_in_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Date Picker Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 16.0);
    return Scaffold(
      appBar: AppBar(title: Text('Date Picker Demo')),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              color: Colors.blue,
              child: Text("DatePicker Bottom Sheet", style: textStyle),
              onPressed: () {
                showTime(context);
              },
            ),
          ],
        ),
      ),
    );
  }

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
  void showTime(BuildContext context) {
    DatePicker.showDatePicker(context,
      locale: DateTimePickerLocale.zh_cn,
      minDateTime: DateTime(2000),
      maxDateTime: DateTime(2030),
      onCancel: () {DYXToast.showToast("确定了");}
    );
  }
}
