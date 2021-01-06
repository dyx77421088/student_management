import 'package:flutter/material.dart';
import 'package:student_management/core/model/regular_add_record/regular_add_record_model.dart';
import 'package:student_management/core/services/clazz/clazz_search.dart';
import 'package:student_management/core/services/work/work_insert.dart';
import 'package:student_management/core/utils/date_time_utils.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/pages/personal/work/work_content.dart';
import 'package:student_management/ui/shared/toast/toast.dart';
import 'package:student_management/core/model/work/work_single.dart';

class DYXWorkPage extends StatefulWidget {
  static const String routeName = "/DYXWorkPage";
  static const String routeNameUpdate = "/DYXWorkPageUpdate";
  final DYXWorkSingleModel work;


  DYXWorkPage({this.work});

  @override
  _DYXWorkPageState createState() => _DYXWorkPageState();
}

class _DYXWorkPageState extends State<DYXWorkPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  Map<String, dynamic> d = {};
  List<DYXItem> list = [];

  @override
  void initState() {
    super.initState();
    initList();
    initData();
  }

  initList() async{
    var data = await DYXClazzSearch.searchByTeacherToken();
    list = [];
    data.results.forEach((a) => list.add(new DYXItem(a.className, id: a.id)));
    setState(() {d['check'] = list;});
  }

  /// 初始化数据
  void initData() {
    if (widget.work == null) return;
    d['startDate'] = DYXDateTimeUtils.timeStampToDateTime(timeStamp: widget.work.startDate);
    d['startTime'] = DYXDateTimeUtils.timeStampToDateTime(timeStamp: widget.work.startDate);
    d['endDate'] = DYXDateTimeUtils.timeStampToDateTime(timeStamp: widget.work.endDate);
    d['endTime'] = DYXDateTimeUtils.timeStampToDateTime(timeStamp: widget.work.endDate);

    d['course'] = switchCourseType(widget.work.course);

    titleController.text = widget.work.title;
    contentController.text = widget.work.content;
  }

  DYXCourse switchCourseType(String course) {
    switch(course) {
      case "语文": return DYXCourse.yuwen;
      case "数学": return DYXCourse.shuxue;
      case "英语": return DYXCourse.yingyu;
      case "体育": return DYXCourse.tiyu;
    }
    return DYXCourse.yuwen;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("作业"), actions: [
        FlatButton(
          child: Text(widget.work==null?'发布':"修改", style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),),
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

            // 创建work
            insertWork(context);

          },
        )
      ],),
      body: SingleChildScrollView(child: DYXWorkContent(titleController, contentController,d)),
    );
  }

  /// 新增一条work
  void insertWork(BuildContext context) {
    int t1 = DYXDateTimeUtils.dateTimeToTimeStamp(date: d['startDate'], time: d['startTime']);
    int t2 = DYXDateTimeUtils.dateTimeToTimeStamp(date: d['endDate'], time: d['endTime']);
    if (t1 < DYXDateTimeUtils.getNowTimeStamp()) {
      DYXToast.showToast("开始时间不能早于当前时间");
      return;
    }
    bool isCheck = false;
    list.forEach((element) async{
      if (!element.check) return; // 没有勾选
      isCheck = true;
      var data = await DYXWorkInsert.insert(
          course: switchCourse(d['course'] ?? DYXCourse.yuwen),
          title: titleController.text,
          content: contentController.text,
          releaseTime: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          teacher: DYXUserViewModel.teacherId,
          startDate: t1,
          endDate: t2,
          clazz: element.id // 班级id
      );
      if (data['code'] == 200) {
        DYXToast.showToast("发布作业成功");

      }
    });

    if (!isCheck) {
      DYXToast.showToast("请选择需要发送的班级");
    } else {
      Navigator.pop(context);
    }
  }

  /// 修改work
  void updateWork(BuildContext context) {
    int t1 = DYXDateTimeUtils.dateTimeToTimeStamp(date: d['startDate'], time: d['startTime']);
    int t2 = DYXDateTimeUtils.dateTimeToTimeStamp(date: d['endDate'], time: d['endTime']);
    if (t1 < DYXDateTimeUtils.getNowTimeStamp()) {
      DYXToast.showToast("开始时间不能早于当前时间");
      return;
    }

    bool isCheck = false;
    list.forEach((element) async{
      if (!element.check) return; // 没有勾选
      isCheck = true;
      var data = await DYXWorkInsert.insert(
          course: switchCourse(d['course'] ?? DYXCourse.yuwen),
          title: titleController.text,
          content: contentController.text,
          releaseTime: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          teacher: DYXUserViewModel.teacherId,
          startDate: t1,
          endDate: t2,
          clazz: element.id // 班级id
      );
      if (data['code'] == 200) {
        DYXToast.showToast("修改作业成功");
      }
    });

    if (!isCheck) {
      DYXToast.showToast("请选择需要发送的班级");
    } else {
      Navigator.pop(context);
    }
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

class DYXItem {
  int id;
  String _text;
  bool check;
  DYXItem(this._text, {@required this.id, this.check = false});
  String get text => _text;

  @override
  String toString() {
    return 'DYXItem{_text: $_text, check: $check}';
  }
}
