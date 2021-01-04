import 'dart:io';

import 'package:flutter/material.dart';

import 'package:nova_alarm_plugin/nova_alarm_plugin.dart';

void main() async {
  await NovaAlarmPlugin.initClockService(title: "标题",content:"我爱洗澡皮肤好好");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController titleController =
  new TextEditingController(text: "title");
  final TextEditingController contentController =
  new TextEditingController(text: "content");

  @override
  void initState() {
    super.initState();
  }

  void requestPermission() async {
    if (Platform.isAndroid) {
      await NovaAlarmPlugin.requestCalendarPermission();
    } else {
      await NovaAlarmPlugin.requestClockPermission();
    }
  }

  void getClock() async {
    bool result = await NovaAlarmPlugin.isClockAvailable();
    print("getClock $result");
  }

  void setClock() async {
    print("setclock");
//    await AndroidAlarmManager.oneShot(
//        const Duration(seconds: 2), 1, showNotification);

    var dateTime = new DateTime.now();

    var clockId100 = 100;
    String time = (dateTime.millisecondsSinceEpoch + 90 * 1000).toString();
    print(time);

    NovaAlarmPlugin.setClock(
      time,
      clockId100,
      title: "title-test",
      content: "content-test1",
    );

//    print("setClock $result");

    // bool result = await FlutterClockPlugin.setClock(
    //     dateTime.millisecond.toString(), titleController.text,
    //     title: titleController.text, content: contentController.text);
    // print("setClock$result");
  }

  void cancelClock() async {
    bool result = await NovaAlarmPlugin.closeClock();
    print("cancelClock$result");
  }

  void insertCalendarEvent() async {
    var now = new DateTime.now();
    var dateTime =
    new DateTime(now.year, now.month, now.day + 3, now.hour, now.minute);
    var beginTime = dateTime.millisecondsSinceEpoch;
    await NovaAlarmPlugin.insertCalenderEvent(beginTime, "大姨妈来了", "大姨妈来了好疼", 3,
        repeatDay: true);
  }

  void deleteCalendarEvent() async {
    await NovaAlarmPlugin.deleteCalendarEvent("大姨妈来了");
    print("editCalendarEvent");
  }

  void setiOSRepeatNotificaition() async {
    var now = new DateTime.now();
    var dateTime =
    new DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second + 80);
    var beginTime = dateTime.millisecondsSinceEpoch;
    var timeString = beginTime.toString();
    bool result = await NovaAlarmPlugin.setiOSRepeatSpecificTimeNotification(timeString, 2222, 3, null, "通知标题", "通知的内容");
    print("setiOSRepeatNotificaition$result");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin Clock app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Wrap(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                      onPressed: requestPermission, child: Text("请求权限")),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(onPressed: getClock, child: Text("通知是否可")),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(onPressed: setClock, child: Text("设置闹钟")),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                      onPressed: cancelClock, child: Text("取消指定title闹钟")),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                      onPressed: insertCalendarEvent, child: Text("添加日历")),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                      onPressed: deleteCalendarEvent, child: Text("删除日历")),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    onPressed: setiOSRepeatNotificaition, child: Text("iOS重复通知"),
                  )
                ],
              ),
              TextField(
                controller: titleController,
              ),
              TextField(
                controller: contentController,
              ),
            ],
          ),
        ),
      ),
    );
  }

}