import 'package:flutter/material.dart';
import 'package:nova_alarm_plugin/nova_alarm_plugin.dart';
import 'package:student_management/core/utils/date_time_utils.dart';
import 'package:student_management/ui/shared/date_picker/date_picker_utils.dart';
import 'package:student_management/ui/shared/notifications/awesome_notifications_utils.dart';

class DYXPage2 extends StatefulWidget {

  @override
  _DYXPage2State createState() => _DYXPage2State();
}

class _DYXPage2State extends State<DYXPage2> {
  int id = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('page2'),),
      body: Container(
          child: Column(
            children: [
              RaisedButton(
                child: Text("发送通知"),
                onPressed: () {DYXAwesomeNotificationsUtils.sendNotifications(id: ++id);},
              ),
              RaisedButton(
                child: Text("添加闹钟"),
                onPressed: (){addClock(context);},
              ),
            ],
          )
      ),
    );
  }

  void addClock(BuildContext context) {
    DateTime date;
    DYXDatePickerUtils.showTime(
      context: context,
      dateFormat: "HH时-mm分",
      initialDateTime: DateTime.now(),
      onConfirm: (DateTime dateTime, List<int> selectedIndex) {
        NovaAlarmPlugin.setClock(
          dateTime.millisecondsSinceEpoch.toString(),
          100,
          title: "我是标题",
          content: "我是内容",
        );
      }
    );
  }
  void addClock2(DateTime date, BuildContext context) {
    DYXDatePickerUtils.showTime(
        context: context,
        dateFormat: "HH时-mm分",
        initialDateTime: DateTime.now(),
        onConfirm: (DateTime dateTime, List<int> selectedIndex) {
          NovaAlarmPlugin.setClock(
            dateTime.millisecondsSinceEpoch.toString(),
            100,
            title: "我是标题",
            content: "我是内容",
          );
        }
    );
  }
}
