import 'package:flutter/material.dart';
import 'package:student_management/core/extension/int_extension.dart';

class DYXMainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.px,
      child: Drawer(
        child: Column(
          children: <Widget>[
            buildHeaderView(context),
            buildListTile(context, Icon(Icons.restaurant), "进餐",() {
              Navigator.of(context).pop();
            }),
            buildListTile(context, Icon(Icons.settings), "过滤", () {
              Navigator.of(context).pop();
            }),
          ],
        ),
      ),
    );
  }

  Widget buildHeaderView(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.px,
      color: Colors.orange,
      alignment: Alignment(0, 0.5),
      margin: EdgeInsets.only(bottom: 20.px),
      child: Text('开始动手', style: Theme.of(context).textTheme.headline5,),
    );
  }

  Widget buildListTile(BuildContext context, Widget icon, String title, Function onTap) {
    return ListTile(
      leading: icon,
      title: Text(title, style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),),
      onTap: onTap,
    );
  }
}
