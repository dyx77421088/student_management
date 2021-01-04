import 'package:flutter/material.dart';
import 'package:student_management/core/services/work/work_insert.dart';
import 'package:student_management/core/utils/date_time_utils.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/pages/personal/work/work_content.dart';
import 'package:student_management/ui/shared/toast/toast.dart';

class DYXWorkPage extends StatefulWidget {
  static const String routeName = "/DYXWorkPage";

  @override
  _DYXWorkPageState createState() => _DYXWorkPageState();
}

class _DYXWorkPageState extends State<DYXWorkPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  Map<String, dynamic> d = {};

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("作业"), actions: [
        FlatButton(
          child: Text('发布', style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),),
          onPressed: () async{
            if (titleController.text.trim().length <= 0) {
              DYXToast.showToast("标题不能为空");
              return;
            } else if (contentController.text.trim().length <= 0) {
              DYXToast.showToast("内容不能为空");
              return;
            }
            if (d['startDate'] == null || d['startTime'] == null ||
                d['endDate'] == null || d['endTime'] == null) {
              DYXToast.showToast("有空的时间");
              return;
            }
            int t1 = DYXDateTimeUtils.dateTimeToTimeStamp(date: d['startDate'], time: d['startTime']);
            int t2 = DYXDateTimeUtils.dateTimeToTimeStamp(date: d['endDate'], time: d['endTime']);

            var data = await DYXWorkInsert.insert(
              course: switchCourse(d['course'] ?? DYXCourse.yuwen),
              title: titleController.text,
              content: contentController.text,
              releaseTime: DateTime.now().millisecondsSinceEpoch ~/ 1000,
              teacher: DYXUserViewModel.teacherId,
              startDate: t1,
              endDate: t2,
              clazz: 1
            );
            if (data['code'] == 200) {
              DYXToast.showToast("发布作业成功");
              Navigator.pop(context);
            }
          },
        )
      ],),
      body: DYXWorkContent(titleController, contentController,d),
    );
  }

  String switchCourse(DYXCourse course) {
    switch(course) {
      case DYXCourse.yuwen: return "语文";
      case DYXCourse.yingyu: return "英语";
      case DYXCourse.shuxue: return "数学";
      case DYXCourse.tiyu: return "体育";
    }
    return "未知";
  }
}
