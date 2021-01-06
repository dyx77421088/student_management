import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/core/model/work/work_single.dart';
import 'package:student_management/core/services/work/work_delete.dart';
import 'package:student_management/core/utils/date_time_utils.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/image/image_network.dart';
import 'package:student_management/ui/shared/toast/toast.dart';
import 'package:student_management/ui/pages/personal/work/work.dart';

class DYXSingleWorkLookPage extends StatefulWidget {
  static const String routeName = "/DYXSingleWorkLookPage";
  static const String routeNameCanUpdate = "/DYXSingleWorkLookPage2";
  final DYXWorkSingleModel result;
  // 是否能够编辑
  final bool canUpdate;


  DYXSingleWorkLookPage(this.result,{this.canUpdate = true});

  @override
  _DYXSingleWorkLookPageState createState() => _DYXSingleWorkLookPageState();
}

class _DYXSingleWorkLookPageState extends State<DYXSingleWorkLookPage> {
  var penKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.result.title), actions: [
        widget.canUpdate ? IconButton(
          key: penKey,
          icon: Icon(DYXIcons.settings),
          onPressed: penClick
        ) : Text("")
      ],),
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
  /// 点击笔之后的执行的
  void penClick() {
    PopupMenu(
      context: context,
      maxColumn: 1,
      items: [
        MenuItem(title: '删除', image: Icon(Icons.delete, color: Colors.white,)),
        // MenuItem(title: '编辑', image: Icon(Icons.delete, color: Colors.white,)),
      ],
      onClickMenu: (MenuItemProvider item) {
        if(item.menuTitle == "删除") {
          del();
        } else if(item.menuTitle == "编辑") {
          Navigator.pushNamed(context, DYXWorkPage.routeNameUpdate, arguments: widget.result);
        }
      },
    )..show(widgetKey: penKey);
  }

  /// 删除
  void del() async{
    await DYXWorkDelete.del(id: widget.result.id);
    DYXToast.showToast("删除成功");
    Navigator.pop<dynamic>(context, widget.result.id);
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
