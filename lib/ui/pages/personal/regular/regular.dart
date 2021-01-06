import 'package:flutter/material.dart';
import 'package:student_management/core/utils/date_time_utils.dart';
import 'package:student_management/ui/pages/personal/regular/regular_content.dart';
import 'package:student_management/ui/pages/personal/regular/regular_target.dart';
import 'package:student_management/ui/shared/date_picker/date_picker_utils.dart';
import 'package:student_management/ui/shared/icon/icons.dart';

import 'regular_add/regular_add.dart';

class DYXRegularPage extends StatefulWidget {
  static const String routeName = "/DYXRegularPage";

  @override
  _DYXRegularPageState createState() => _DYXRegularPageState();
}

class _DYXRegularPageState extends State<DYXRegularPage> {
  var _index = 0;
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('打卡(${DYXDateTimeUtils.getNowDate(timeStamp: DYXDateTimeUtils.getNowTimeStamp(now: now))})'),
        actions: [
          IconButton(icon: Icon(DYXIcons.calendar), onPressed: (){
            showCalendar(context);
          })
        ],
      ),
      body: DYXRegularContent(now),
      // floatingActionButton: FloatingActionButton(
      //   tooltip: "添加",
      //   child: Icon(DYXIcons.add),
      //   onPressed: () {
      //     Navigator.pushNamed(context, DYXRegularAddPage.routeName);
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _index,
      //   items: [
      //     BottomNavigationBarItem(
      //       label: '打卡',
      //       icon: Icon(DYXIcons.calendar),
      //     ),
      //     BottomNavigationBarItem(
      //       label: '目标任务',
      //       icon: Icon(DYXIcons.target)
      //     )
      //   ],
      //   onTap: (index) {
      //     setState(() {
      //       _index = index;
      //     });
      //   },
      // ),
    );
  }

  /// 选择日期
  void showCalendar(BuildContext context) {
    DYXDatePickerUtils.showTime(
      context: context,
      initialDateTime: now,
      onConfirm: (DateTime dateTime, List<int> selectedIndex) {
        setState(() {
          this.now = dateTime;
        });
      }
    );
  }
}
