import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/model/user/user_login_model.dart';
import 'package:student_management/core/services/login/user_request.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/shared/animation/flare_status.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';
import 'package:student_management/ui/shared/toast/toast.dart';
import 'package:student_management/ui/widgets/my_text_form_field.dart';

import 'login_content.dart';

class DYXLoginUser extends StatefulWidget {
  final UpdateFlare flare;

  DYXLoginUser(this.flare);

  @override
  _DYXLoginUserState createState() => _DYXLoginUserState();
}

class _DYXLoginUserState extends State<DYXLoginUser> with SingleTickerProviderStateMixin{
  //表单中的key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //用户名的控制器
  TextEditingController _userController = TextEditingController();
  //密码的控制器
  TextEditingController _pwdController = TextEditingController();

  // 密码的焦点
  FocusNode passwordFocusNode;
  @override
  void initState() {
    super.initState();
    passwordFocusNode = FocusNode();
    passwordFocusNode.addListener(() {
      print('进来了!!!');
      if(passwordFocusNode.hasFocus) {
        widget.flare(DYXTeddy.hands_up);
      } else {
        widget.flare(DYXTeddy.hands_down);
      }
    });
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildInfo();
  }

  Widget buildInfo() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          buildUser(),
          buildPassword(),
          buildButton()
        ],
      ),
    );
  }

  /// 用户名
  Widget buildUser() {
    return DYXTextFormField(
      leftIcon: Icon(DYXIcons.account),
      labelText: "用户名",
      controller: _userController,
    );
  }

  /// 密码输入框
  Widget buildPassword() {
    return DYXTextFormField(
      focusNode: passwordFocusNode,
      leftIcon: Icon(DYXIcons.password),
      labelText: "密码",
      isPassword: true,
      controller: _pwdController,
    );
  }

  /// 登录按钮
  Widget buildButton() {
    return Container(
      width: double.infinity,
      child: Consumer<DYXUserViewModel>(
        builder: (ctx, userVM, child) => FlatButton(
          child: Text('登录'),
          onPressed: () {
            //先验证输入是否合法，合法执行后面的
            if(_formKey.currentState.validate()) {
              DYXUserRequest.onUserLogin(_userController.text, _pwdController.text)
                  .then((value) => saveUserInfo(value, userVM)).catchError((_){widget.flare(DYXTeddy.fail);});
            } else { // 熊哭泣
              widget.flare(DYXTeddy.fail);
            }
          },
          textColor: Colors.white,
          color: DYXColors.blue,
        ),
      ),
    );
  }

  /// 保存用户信息
  void saveUserInfo(DYXUserLoginModel user, DYXUserViewModel userVM) {
    if(user == null) return;
//    print("用户名:${user.data.userName}");
//    print("用户名:${user.data.name}");
//    print("用户名:${user.data.phoneNumber}");
//    print("用户名:${user.data.school}");
    widget.flare(DYXTeddy.success);
    Navigator.pop(context);
    DYXToast.showToast("登录成功");
    userVM.user = user;
  }
}
