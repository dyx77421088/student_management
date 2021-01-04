import 'package:flutter/material.dart';
import 'package:student_management/core/model/work/work_search.dart' as work;
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/core/utils/date_time_utils.dart';
import 'package:student_management/ui/shared/image/image_network.dart';

class DYXSingleWorkLookPage extends StatefulWidget {
  static const String routeName = "/DYXSingleWorkLookPage";
  final work.Result result;


  DYXSingleWorkLookPage(this.result);

  @override
  _DYXSingleWorkLookPageState createState() => _DYXSingleWorkLookPageState();
}

class _DYXSingleWorkLookPageState extends State<DYXSingleWorkLookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.result.title),),
      body: Column(
          children: [
            buildMakeTitle(context, "发布老师"),
            buildMakeSteps(context, ListTile(
              leading: buildAvatarImg(widget.result.userDetails.avatar),
              title: Text(widget.result.userDetails.name),
            )),
            buildMakeTitle(context, "作业时间"),
            buildMakeSteps(context, Column(
              children: [
                Row(children: [
                  Text("开始时间:"),
                  SizedBox(width: 20.px,),
                  Text(DYXDateTimeUtils.dateTimeToDate(timeStamp: widget.result.startDate)),
                ],),
                SizedBox(height: 10.px,),
                Row(children: [
                  Text("结束时间:"),
                  SizedBox(width: 20.px,),
                  Text(DYXDateTimeUtils.dateTimeToDate(timeStamp: widget.result.endDate))
                ],),
              ],
            )),
            buildMakeTitle(context, "作业内容"),
            buildMakeSteps(context, Text(widget.result.content)),
            buildMakeTitle(context, "作业要求"),
            buildMakeSteps(context, Text(widget.result.request??"无")),
          ],
      ),
    );
  }

  /// 标题
  Widget buildMakeTitle(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.px),
      child: Center(child: Text(title, style: Theme.of(context).textTheme.headline3.copyWith(fontWeight: FontWeight.bold),)),
    );
  }

  Widget buildMakeSteps(BuildContext context, Widget child) {
    return buildMakeContent(
        context: context,
        child: child
    );
  }

  /// 头像
  Widget buildAvatarImg(String avatar) {
    if (avatar != null) {
      return Container(
          width: 30.px,
          height: 30.px,
          margin: EdgeInsets.symmetric(horizontal: 10.px),
          child: DYXImageNetwork.avatarNetwork(url: avatar)
      );
    }
    return Container(
      width: 30.px,
      height: 30.px,
      margin: EdgeInsets.symmetric(horizontal: 10.px),
      child: CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage("assets/images/avatar_unlogin.png"),
        backgroundColor: Colors.white,
      ),
    );
  }

  /// 内容
  Widget buildMakeContent({@required BuildContext context, @required Widget child}) {
    return Container(
      width: MediaQuery.of(context).size.width - 30.px,
      padding: EdgeInsets.all(8.px),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(6.px)
      ),
      child: child,
    );
  }
}
