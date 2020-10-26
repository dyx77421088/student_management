import 'package:flutter/material.dart';
import 'package:student_management/core/services/regular_add_record/regular_add_record.dart';
import 'package:student_management/core/utils/date_time_utils.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/pages/personal/regular/regular_add/regular_add_record/regular_add_record_content.dart';
import 'package:student_management/core/model/regular/regular_search_model.dart';
import 'package:student_management/ui/shared/toast/toast.dart';

class DYXRegularAddRecordPage extends StatefulWidget {
  static const String routeName = "DYXRegularAddRecordPage";
  final Result regular;
  DYXRegularAddRecordPage(this.regular);

  @override
  _DYXRegularAddRecordPageState createState() => _DYXRegularAddRecordPageState();
}

class _DYXRegularAddRecordPageState extends State<DYXRegularAddRecordPage> {
  Map<String, dynamic> map = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新的习惯"),
        actions: [
          FlatButton(child: Text('保存', style: TextStyle(color: Colors.white),), onPressed: (){
            if (map['week'] == null || map['week'].length <= 0) {
              DYXToast.showToast("重复周期不能为空");
              return;
            }
            DYXRegularAddRecordServices.insert(
              token: DYXUserViewModel.staticToken,
              describe: widget.regular.describe,
              regular: widget.regular.id,
              reminderTime: DYXDateTimeUtils.getTimeStamp(map['reminderTime']),
              startTime: DYXDateTimeUtils.getTimeStamp(map['startTime']),
              endTime: DYXDateTimeUtils.getTimeStamp(map['endTime']),
              startDate: DYXDateTimeUtils.getTimeStamp(map['startDate']),
              endDate: DYXDateTimeUtils.getTimeStamp(map['endDate']),
              week: map['week']
            ).then((value) {
              if(value['code'] == 200) {
                // 添加成功
                Navigator.pop(context);
              }
            });
          },)
        ],
      ),
      body: DYXRegularAddRecordContent(widget.regular, map),
    );
  }
}
