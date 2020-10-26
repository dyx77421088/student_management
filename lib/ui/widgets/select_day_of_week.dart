import 'package:flutter/material.dart';

class DYXSelectDayOfWeek extends StatefulWidget {
  final List<bool> weekCheck;
  DYXSelectDayOfWeek(this.weekCheck);

  @override
  _DYXSelectDayOfWeekState createState() => _DYXSelectDayOfWeekState();
}

class _DYXSelectDayOfWeekState extends State<DYXSelectDayOfWeek> {

  List<String> weekStr = [
    "星期一", "星期二","星期三","星期四","星期五","星期六","星期天",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: buildWeek(),
    );
  }

  Widget buildWeek() => ListView.builder(
    itemCount: widget.weekCheck.length,
    itemBuilder: (BuildContext context, int index) => ListTile(
      leading: Checkbox(value: widget.weekCheck[index], onChanged: (b){
        setState(() {
          widget.weekCheck[index] = b;
        });
      }),
      title: Text(weekStr[index]),
    )
  );
}
