import 'package:flutter/material.dart';
import 'package:flutter_timetable_view/flutter_timetable_view.dart';

class DYXTimeTable extends StatelessWidget {
  final double width;
  final List<LaneEvents> laneEventsList;

  DYXTimeTable({@required this.laneEventsList, this.width=150});

  @override
  Widget build(BuildContext context) {
    return TimetableView(
      laneEventsList: laneEventsList,
      timetableStyle: TimetableStyle(
        startHour: 5,
        endHour: 22,
        laneWidth: width,
        timeItemHeight: 90
      ),
    );
  }
}
