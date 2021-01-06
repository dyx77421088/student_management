import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:student_management/core/utils/date_time_utils.dart';
import 'package:student_management/ui/shared/date_picker/date_picker_utils.dart';
import 'package:student_management/ui/shared/dialog/dialog.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/ui/widgets/select_class.dart';
import 'package:student_management/ui/pages/personal/work/work.dart';

class DYXWorkContent extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;
  final Map<String, dynamic> d;

  DYXWorkContent(this.titleController, this.contentController, this.d);

  @override
  _DYXWorkContentState createState() => _DYXWorkContentState();
}

class _DYXWorkContentState extends State<DYXWorkContent> {
  DateTime startDate, startTime, endDate, endTime;
  DYXCourse _course = DYXCourse.yuwen;
  List<DYXItem> list = [];

  @override
  void initState() {
    super.initState();
    // list = widget.d['check'] ?? [];
    startDate = widget.d['startDate'];
    startTime = widget.d['startTime'];
    endDate = widget.d['endDate'];
    endTime = widget.d['endTime'];
    _course = widget.d['course']??DYXCourse.yuwen;
  }

  @override
  Widget build(BuildContext context) {
    list = widget.d['check'] ?? [];
    return Column(
      children: [
        buildTitle(),
        buildContent(),
        buildSelectedClass(),
        buildSelectClass(),
        SizedBox(height: 10.px,),
        Row(children: [
            buildDate(context, true, DYXTimeStatus.startDate),
            buildTime(context, true, DYXTimeStatus.startTime),
          ],
        ),
        SizedBox(height: 10.px,),
        Row(
          children: [
            buildDate(context, false, DYXTimeStatus.endDate),
            buildTime(context, false, DYXTimeStatus.endTime),
          ],
        ),
        SizedBox(height: 10.px,),
        buildAdd()
      ],
    );
  }
  // 选择了的班级
  Widget buildSelectedClass() {
    bool b = true;
    String str = "";
    list.forEach((a)  {
      if (a.check) {
        b = false;
        str += '${a.text},';
      }
    });
    if (b) return Text("暂无选择班级");
    return Text(str.substring(0, str.length - 1));
  }
  /// 选择班级
  Widget buildSelectClass() {
    return RaisedButton(onPressed: (){
      clickSex(context);
    }, child: Text("选择班级"),);
  }
  /// 用户详情中单击用户名后的监听
  void clickSex(BuildContext context) {


    DYXDialog.showDialog(
      context: context,
      body: DYXSelectClass(list),
      dialogType: DialogType.NO_HEADER,
      btnCancelOnPress: (){},
      btnOkOnPress: (){
        list.forEach((a)=>print(a.check));
        setState(() {});
      },
    );
  }


  /// 添加
  Widget buildAdd() {
    return Container(
      padding: EdgeInsets.all(10.px),
      child: Row(
          children: [
            GestureDetector(
              child: Icon(DYXIcons.add_image, size: 40.px,),
              onTap: (){},
            )
          ],
        ),
    );
  }

  /// 内容
  Widget buildContent() {
    return Container(
      padding: EdgeInsets.all(10.px),
      child: TextFormField(
          controller: widget.contentController,
          maxLines: 12,
          maxLength: 250,
          autofocus: true,
          decoration: InputDecoration(
              counterText: "",
              //输入框内边距
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //输入框内容提示
              hintText: '内容',
              //输入框边距线
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.px))
          )
      ),
    );
  }

/// 标题
  Widget buildTitle() {
    return Container(
        padding: EdgeInsets.all(10.px),
        child: TextFormField(
          controller: widget.titleController,
          maxLines: 1,
          maxLength: 20,
          autofocus: true,
          decoration: InputDecoration(
            counterText: "",
            //输入框内边距
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //输入框内容提示
            hintText: '请输入标题',
            //输入框边距线
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.px)),
            suffixIcon: DropdownButton(
              items: [
                DropdownMenuItem(child: Text("语文"), onTap: (){}, value: DYXCourse.yuwen,),
                DropdownMenuItem(child: Text("英语"), onTap: (){}, value: DYXCourse.yingyu,),
                DropdownMenuItem(child: Text("数学"), onTap: (){}, value: DYXCourse.shuxue,),
                DropdownMenuItem(child: Text("体育"), onTap: (){}, value: DYXCourse.tiyu,),
              ],
              hint: Text(switchCourse(_course)),
              onChanged: (t){
                setState(() {
                  _course = t;
                  widget.d['course'] = t;
                });
              },
            ),
          ),

        ),
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

  /// 开始(结束)日期
  Widget buildDate(BuildContext context, bool start, DYXTimeStatus status) => FlatButton(onPressed: (){
    DYXDatePickerUtils.showTime(
      context: context,
      initialDateTime: start ? startDate : endDate,
      dateFormat: "yyyy-MM-dd",
      onConfirm: (DateTime dateTime, List<int> selectedIndex) {
        setState(() {
          if (start) {
            startDate = dateTime;
            widget.d['startDate'] = dateTime;
          }
          else {
            endDate = dateTime;
            widget.d['endDate'] = dateTime;
          }
        });
      }
    );
  }, child: Text(buildText(status)));
  /// 开始(结束)时间
  Widget buildTime(BuildContext context, bool start, DYXTimeStatus status) => FlatButton(onPressed: (){
    DYXDatePickerUtils.showTime(
        context: context,
        initialDateTime: start ? startTime : endTime,
        dateFormat: "HH:mm",
        onConfirm: (DateTime dateTime, List<int> selectedIndex) {
          setState(() {
            if (start) {
              startTime = dateTime;
              widget.d['startTime'] = dateTime;
            }
            else {
              endTime = dateTime;
              widget.d['endTime'] = dateTime;
            }
          });
        }
    );
  }, child: Text(buildText(status)));


  String buildText(DYXTimeStatus status) {
    switch(status) {
      case DYXTimeStatus.startDate: return startDate == null ? "开始日期" :
        DYXDateTimeUtils.getNowDate(timeStamp: startDate.millisecondsSinceEpoch~/1000);
      case DYXTimeStatus.startTime: return startTime == null ? "开始时间" :
      DYXDateTimeUtils.getNowTime(timeStamp: startTime.millisecondsSinceEpoch~/1000);
      case DYXTimeStatus.endDate: return endDate == null ? "结束日期" :
      DYXDateTimeUtils.getNowDate(timeStamp: endDate.millisecondsSinceEpoch~/1000);
      case DYXTimeStatus.endTime: return endTime == null ? "结束时间" :
      DYXDateTimeUtils.getNowTime(timeStamp: endTime.millisecondsSinceEpoch~/1000);
    }
    return "??";
  }
}

enum DYXTimeStatus {
  startDate,
  startTime,
  endDate,
  endTime,
}

enum DYXCourse {
  yuwen, // 语文
  yingyu, // 英语
  shuxue, // 数学
  tiyu, // 体育
}
