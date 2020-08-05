import 'package:flutter/material.dart';
import 'package:student_management/ui/shared/icon/icons.dart';

class DYXSettingItem extends StatelessWidget {
  final String title;
  final Widget leading;
  final Function onPressed;
  final Widget trailing;

  DYXSettingItem({this.title, this.leading, @required this.onPressed, this.trailing = const Icon(DYXIcons.chevron_right)});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
        padding: EdgeInsets.zero,
        color: Theme.of(context).dialogBackgroundColor,
        child: ListTile(
            leading: leading,
            title: Text(title),
            trailing: trailing),
        onPressed: onPressed);
  }
}
