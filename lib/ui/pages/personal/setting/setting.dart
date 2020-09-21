import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/shared/dialog/dialog.dart';
import 'package:student_management/ui/shared/toast/toast.dart';

import 'setting_content.dart';

class DYXSettingPage extends StatelessWidget {
  static const String routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('设置'),),
      body: DYXSettingContent(),
      bottomSheet: Consumer<DYXUserViewModel>(
        builder: (ctx, userVM, child) => Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: userVM.isLogin ? buildExitButton(context, userVM) : Text(''),
        ),
      ),
    );
  }

  /// 退出按钮
  Widget buildExitButton(BuildContext context, DYXUserViewModel userVM) =>
    DYXDialog.dialogButton(
      context: context,
      buttonText: "退出登录",
      desc: "是否退出",
      dialogType: DialogType.INFO,
      btnOkOnPress: (){
        userVM.logOut();
        DYXToast.showToast("成功退出用户!");
        Navigator.of(context).pop();
      },
      btnCancelOnPress: () {}
    );
}
