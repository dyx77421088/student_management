import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:student_management/core/model/regular/regular_search_model.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/core/extension/double_extension.dart';
import 'package:student_management/core/utils/date_time_utils.dart';
import 'package:student_management/ui/pages/personal/details/details_click.dart';
import 'package:student_management/ui/shared/date_picker/date_picker_utils.dart';
import 'package:student_management/ui/shared/dialog/dialog.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/widgets/select_day_of_week.dart';
import 'package:student_management/ui/widgets/setting_item.dart';

/// 时间的状态, 开始时间，结束时间，提醒时间
enum DYXTimeStatus {
  START_TIME, END_TIME, REMINDER_TIME
}

class DYXRegularAddRecordContent extends StatefulWidget {
  final Result regular;
  final Map<String, dynamic> map;
  DYXRegularAddRecordContent(this.regular, this.map);

  @override
  _DYXRegularAddRecordContentState createState() => _DYXRegularAddRecordContentState();
}

class _DYXRegularAddRecordContentState extends State<DYXRegularAddRecordContent> {
  /// 开始时间
  DateTime startTime = DateTime.now();
  /// 结束时间
  DateTime endTime = DateTime.now();
  /// 开始的日期
  DateTime startDate = DateTime.now();
  /// 结束的日期
  DateTime endDate = DateTime.now();
  /// 提醒时间
  DateTime reminderTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    widget.map["startTime"] = startTime;
    widget.map["endTime"] = endTime;
    widget.map["startDate"] = startDate;
    widget.map["endDate"] = endDate;
    widget.map["reminderTime"] = reminderTime;
    widget.map["week"] = getIntWeek();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.px),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.px)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle(widget.regular.title),
          SizedBox(height: 20.px,),
          buildTitle(widget.regular.describe),
          SizedBox(height: 20.px,),
          buildStartTime(context),
          buildEndTime(context),
          buildStartDate(context),
          buildEndDate(),
          buildRepeatTime(context),
          buildReminderTime(),
        ],
      ),
    );
  }

  /// 水平线
  Widget buildDiv({
    double height = 0.5,
    double width = double.infinity,
    Color color = Colors.black
  }) => SizedBox(width: width, height: height, child: DecoratedBox(decoration: BoxDecoration(
    color: color
),),);

/// 标题
Widget buildTitle(String title) => DYXSettingItem(
  title: title,
  showTrailing: false,
  onPressed: (){},
);

/// 选择日期
void selectDate(bool isStartDate) {
  DYXDatePickerUtils.showTime(
      context: context,
      minDateTime: DateTime.now(),
      maxDateTime: DateTime(2066, 6, 6),
      initialDateTime: isStartDate ? this.startDate : this.endDate,
      dateFormat: "yyyy年-MM月-dd日",
      onConfirm: (DateTime dateTime, List<int> selectedIndex) {
        setState(() {
          if(isStartDate) {
            this.startDate = dateTime;
            widget.map['startDate'] = startDate;
          } else {
            this.endDate = dateTime;
            widget.map['endDate'] = endDate;
          }
        });
      }
  );
}

/// 选择时间
void selectTime(DYXTimeStatus status) {
  DYXDatePickerUtils.showTime(
      context: context,
      initialDateTime: this.reminderTime,
      dateFormat: "HH时-mm分",
      onConfirm: (DateTime dateTime, List<int> selectedIndex) {
        print(selectedIndex);
        setState(() {
          switch(status) {
            case DYXTimeStatus.START_TIME:
              this.startTime = dateTime;
              widget.map['startTime'] = startTime;
              break;
            case DYXTimeStatus.END_TIME:
              this.endTime = dateTime;
              widget.map['endTime'] = endTime;
              break;
            case DYXTimeStatus.REMINDER_TIME:
              this.reminderTime = dateTime;
              widget.map['reminderTime'] = reminderTime;
              break;
          }

        });
      }
  );
}

/// 开始时间
Widget buildStartTime(BuildContext context) => DYXSettingItem(
  title: "开始时间",
  trailing: buildTrailing(DYXDateTimeUtils.dateTimeToTimeStr(this.startTime)),
  onPressed: (){
    selectTime(DYXTimeStatus.START_TIME);
  },
);

/// 结束时间
Widget buildEndTime(BuildContext context) => DYXSettingItem(
  title: "结束时间",
  trailing: buildTrailing(DYXDateTimeUtils.dateTimeToTimeStr(this.endTime)),
  onPressed: (){
    selectTime(DYXTimeStatus.END_TIME);
  },
);

/// 开始日期
Widget buildStartDate(BuildContext context) => DYXSettingItem(
  title: "开始日期",
  trailing: buildTrailing(DYXDateTimeUtils.dateTimeToDateStr(this.startDate)),
  onPressed: (){
    selectDate(true);
  },
);

/// 结束日期
Widget buildEndDate() => DYXSettingItem(
  title: "结束日期",
  trailing: buildTrailing(DYXDateTimeUtils.dateTimeToDateStr(this.endDate)),
  onPressed: (){
    selectDate(false);
  },
);

List<bool> weekCheck = [
  true, true, true, true, true, true, true,
];
/// 重复时间
Widget buildRepeatTime(BuildContext context) => DYXSettingItem(
  title: "重复周期",
  trailing: buildTrailing(repeatTimeStr()),
  onPressed: (){
    DYXDialog.showDialog(
        context: context,
        body: DYXSelectDayOfWeek(weekCheck),
        btnOkOnPress: (){
          setState(() {
            widget.map['week'] = getIntWeek();
          });
        },
        dialogType: DialogType.NO_HEADER
    );
  },
);

/// 选择的week转换成arrayInt
List<int> getIntWeek() {
  List<int> week = [];
  for(int i = 0; i < weekCheck.length; ++i) {
    if(weekCheck[i]) {
      week.add(i+1);
    }
  }
  return week;
}

/// 选择的week转换成str
String repeatTimeStr() {
  List<int> week = getIntWeek();

  if(week.length <= 0) return "无";
  if(week.length == weekCheck.length) return "每天";
  return week.join(",");
}

/// 设置提醒时间
Widget buildReminderTime() => DYXSettingItem(
  title: "提醒时间",
  trailing: buildTrailing(DYXDateTimeUtils.dateTimeToTimeStr(this.reminderTime)),
  onPressed: (){
    // 选择时间
    selectTime(DYXTimeStatus.REMINDER_TIME);
  },
);

/// 后面的widget 包括  文字 + >
Widget buildTrailing(String title) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 200.px,
        alignment: Alignment.centerRight,
        child: Text(title, overflow: TextOverflow.ellipsis,),
      ),
      SizedBox(width: 5.px,),
      Icon(DYXIcons.chevron_right)
    ],
  );
}
}
