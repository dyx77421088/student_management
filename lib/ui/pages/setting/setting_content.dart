import 'package:flutter/material.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/ui/pages/setting/user_security_center/user_security_center.dart';
import 'package:student_management/ui/shared/dialog/dialog.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';
import 'package:student_management/ui/widgets/setting_item.dart';

class DYXSettingContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 10.px),
      children: <Widget>[
        DYXSettingItem(title: "账号安全中心", onPressed: (){
            Navigator.pushNamed(context, DYXUserSecurityCenterPage.routeName);
        },)
      ],
    );
  }
}
