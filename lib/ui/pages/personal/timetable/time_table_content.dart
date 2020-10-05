import 'package:flutter/material.dart';
import 'package:flutter_timetable_view/flutter_timetable_view.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/model/timetable/timetable_model.dart';
import 'package:student_management/core/services/timetable/timetable_select.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/shared/timetable/timetable.dart';

class DYXTimeTableContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DYXUserViewModel>(
      builder: (ctx, userVM, child) => FutureBuilder(
        future: DYXTimetableSelect.selectTimetableByToken(token: userVM.token),
        builder: (ctx, AsyncSnapshot<DYXTimetableModel> snapshot) {
          var dyxTimetable = snapshot.data;
          if(dyxTimetable == null) return Text('未找到课表');

          return DYXTimeTable(
            laneEventsList: buildLaneEvents(dyxTimetable),
          );
        },
      ),
    );

  }

  List<LaneEvents> buildLaneEvents(DYXTimetableModel dyxTimetable) {
    List<LaneEvents> laneEvents = [];
    var colors = [Colors.red, Colors.blue, Colors.yellow, Colors.greenAccent, Colors.pink];
    var i = 0;
    for(var d in dyxTimetable.data) {
      List<TableEvent> events = [];
      for(var e in d.course) {
        events.add(
          TableEvent(title: "${e.courseName}-${e.teacher.name}\n",
            start: TableEventTime(hour: 6 + e.index, minute: 0),
            end: TableEventTime(hour: 7 + e.index, minute: 0),
            backgroundColor: colors[(i++)%colors.length],
        ));
      }
      laneEvents.add(LaneEvents(
        lane: Lane(name: getDayOfWeek(d.week.index), width: 150),
        events: events
      ));
    }
    return laneEvents;
  }
  String getDayOfWeek(day) {
    switch(day) {
      case 1: return "星期一";
      case 2: return "星期二";
      case 3: return "星期三";
      case 4: return "星期四";
      case 5: return "星期五";
      case 6: return "星期六";
      case 7: return "星期日";
    }
    return "???";
  }
}
