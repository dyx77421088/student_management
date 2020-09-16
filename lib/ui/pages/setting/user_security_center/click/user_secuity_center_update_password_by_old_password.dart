import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:student_management/ui/shared/dialog/dialog.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/widgets/my_text_form_field.dart';
import 'package:student_management/core/extension/int_extension.dart';

TextEditingController passwordController;
TextEditingController newPasswordController;
TextEditingController reNewPasswordController;

/// 点击事件
void clickUpdatePassword(BuildContext context) { // 修改密码
  DYXDialog.showDialog(
    context: context,
    dialogType: DialogType.NO_HEADER,
    body: buildUpdatePassword(),
    btnCancelOnPress: (){return false;},
    btnOkOnPress: (){},
    animType: AnimType.RIGHSLIDE,
    useRootNavigator: true,
    onDissmissCallback: () {
      print('我出来了');
      }
  );
}

Widget buildUpdatePassword() => Container(
  padding: EdgeInsets.all(10.px),
  child:   Column(
    children: <Widget>[
      DYXTextFormField(
        controller: passwordController,
        labelText: "旧密码",
        leftIcon: Icon(DYXIcons.password),
      ),
      DYXTextFormField(
        controller: newPasswordController,
        labelText: "新密码",
        leftIcon: Icon(DYXIcons.password),
      ),
      DYXTextFormField(
        controller: reNewPasswordController,
        labelText: "再次输入新密码",
        leftIcon: Icon(DYXIcons.password),
      )
    ],
  ),
);