import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/personal/news/class_notice/class_notice.dart';
import 'package:student_management/ui/pages/personal/news/class_work/class_work.dart';
import 'package:student_management/ui/pages/personal/news/reply/reply.dart';
import 'package:student_management/ui/pages/personal/news/system_notice/system_notice.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';

class DYXNewContent extends StatefulWidget {
  @override
  _DYXNewContentState createState() => _DYXNewContentState();
}

class _DYXNewContentState extends State<DYXNewContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTopNews(),
        buildContent()
      ],
    );
  }

  /// 上方的图标
  Widget buildTopNews() => Container(
    child: Row(
      children: [
        buildTopItem(title: "回复", onPressed: () {
          Navigator.pushNamed(context, DYXReplyPage.routeName);
        }),
        buildTopItem(title: "班级通知", onPressed: () {
          Navigator.pushNamed(context, DYXClassNoticePage.routeName);
        }),
        buildTopItem(title: "班级作业", onPressed: () {
          Navigator.pushNamed(context, DYXClassWorkPage.routeName);
        }),
        buildTopItem(title: "系统通知", onPressed: () {
          Navigator.pushNamed(context, DYXSystemNoticePage.routeName);
        }),
      ],
    ),
  );

  Widget buildContent() => Container(
    width: double.infinity,
    color: Colors.blue,
    child: Column(
      children: [
        Text("消息列表")
      ],
    ),
  );

  /// 每个图标的item的样式
  Widget buildTopItem({IconData icons = DYXIcons.news, String title, Function onPressed}) => Expanded(
    flex: 1,
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.all(5.px),
          width: 50.px,
          height: 50.px,
          decoration: BoxDecoration(
            color: DYXColors.blue[300],
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(icons),
            onPressed: onPressed,
          ),
        ),
        SizedBox(height: 3.px,),
        Text(title, style: TextStyle(color: Colors.black),)
      ],
    ),
  );
}
