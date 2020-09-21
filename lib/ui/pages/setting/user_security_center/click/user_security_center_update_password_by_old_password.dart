import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/services/user/user_update_password.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/shared/dialog/dialog.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';
import 'package:student_management/ui/shared/toast/toast.dart';
import 'package:student_management/ui/widgets/my_text_form_field.dart';
import 'package:student_management/core/extension/int_extension.dart';

/// 点击事件
//void clickUpdatePassword(BuildContext context) { // 修改密码
//  DYXDialog.showDialog(
//      context: context,
//      dialogType: DialogType.NO_HEADER,
//      body: DYXUpdatePasswordByOldPassword(),
//      btnCancelOnPress: (){return false;},
//      btnOkOnPress: (){},
//      animType: AnimType.RIGHSLIDE,
//      useRootNavigator: true,
//      onDissmissCallback: () {
//        print('我出来了');
//      }
//  );
//}
class DYXUpdatePasswordByOldPassword extends StatefulWidget {
  final GlobalKey<InnerDrawerState> _innerDrawerKey;

  DYXUpdatePasswordByOldPassword(this._innerDrawerKey);

  @override
  _DYXUpdatePasswordByOldPasswordState createState() => _DYXUpdatePasswordByOldPasswordState();
}

class _DYXUpdatePasswordByOldPasswordState extends State<DYXUpdatePasswordByOldPassword> {
  //表单中的key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _reNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return buildUpdatePassword();
  }

  Widget buildUpdatePassword() => SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.all(10.px),
//    color: DYXColors.blue[50],
      child: Column(
        children: <Widget>[
//          buildExit(),
          buildForm(),
          SizedBox(height: 10.px,),
          buildUpdateButton()
        ],
      ),
    ),
  );

  /// 修改按钮
  Widget buildUpdateButton() {
    return Consumer<DYXUserViewModel>(
      builder: (ctx, userVM, child) => Container(
          width: double.infinity,
          child: RaisedButton(
            color: DYXColors.blue[100],
            child: Text("修改"),
            onPressed: () {
              if(_formKey.currentState.validate()) {
                updatePassword(userVM);
              }
            },
          ),
        ),
    );
  }

  /// 传参数到服务器修改密码
  void updatePassword(DYXUserViewModel userVM) {
    DYXUserUpdatePassword.updatePasswordByPassword(
      userVM.token,
      _passwordController.text,
      _newPasswordController.text
    );
  }

  /// 表单
  Widget buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            buildTextFormField(_passwordController, "旧密码", null),
            SizedBox(height: 10.px,),
            buildTextFormField(_newPasswordController, "新密码", (value) {
              if(value.length < 6)
                return "密码需要大于等于6位";
              return null;
            }),
            SizedBox(height: 10.px,),
            buildTextFormField(_reNewPasswordController, "再次输入新密码", (value) {
              if(_newPasswordController.text != _reNewPasswordController.text)
                return "两次密码需要一致";
              return null;
            }),
          ],
        ),
      );
  }

  /// 回退箭头
  Widget buildExit() => Container(
    alignment: Alignment.centerLeft,
    child: IconButton(
      icon: Icon(DYXIcons.arrow_left),
      onPressed: (){
//        FocusScope.of(context).requestFocus(FocusNode());
        widget._innerDrawerKey.currentState.close();
      },
    ),
  );

  /// 输入的表单
  Widget buildTextFormField(controller, text, MyValidator validator) => DYXTextFormField(
    controller: controller,
    labelText: text,
    leftIcon: Icon(DYXIcons.password),
    isPassword: true,
    validator: validator,
  );
}

