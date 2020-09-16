import 'package:flutter/material.dart';
import 'package:student_management/ui/widgets/setting_item.dart';
import 'package:student_management/core/extension/int_extension.dart';

import 'click/user_secuity_center_update_password_by_old_password.dart';

class DYXUserSecurityCenterContent extends StatefulWidget {
  @override
  _DYXUserSecurityCenterContentState createState() => _DYXUserSecurityCenterContentState();
}

class _DYXUserSecurityCenterContentState extends State<DYXUserSecurityCenterContent> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 10.px),
      children: <Widget>[
        DYXSettingItem(
          title: "修改密码",
          showTrailing: false,
          onPressed: (){
            clickUpdatePassword(context);
          },
        )
      ],
    );
  }
}
