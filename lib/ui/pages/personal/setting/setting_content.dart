import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/shared/dialog/dialog.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';
import 'package:student_management/ui/widgets/setting_item.dart';

import 'user_security_center/user_security_center.dart';

class DYXSettingContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DYXUserViewModel>(
      builder: (ctx, userVM, child) => ListView(
        padding: EdgeInsets.symmetric(vertical: 10.px),
        children: <Widget>[
          userVM.isLogin ? DYXSettingItem(title: "账号安全中心", onPressed: (){
              Navigator.pushNamed(context, DYXUserSecurityCenterPage.routeName);
          },) : Text(''),
        ],
      ),
    );
  }
}
