import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/model/user/user_model.dart';
import 'package:student_management/core/services/login/login_request.dart';
import 'package:student_management/core/services/user/user_request.dart';
import 'package:student_management/core/viewmodel/user_view_model.dart';
import 'package:student_management/ui/pages/login/login_register_forget.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/image_asset.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';
import 'package:student_management/ui/shared/toast/toast.dart';
import 'package:student_management/ui/widgets/my_text_form_field.dart';
import 'package:student_management/core/extension/int_extension.dart';

import 'package:flutter_icons/flutter_icons.dart';


class DYXLoginUser extends StatefulWidget {
  @override
  _DYXLoginUserState createState() => _DYXLoginUserState();
}

class _DYXLoginUserState extends State<DYXLoginUser> {
  //表单中的key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //用户名的控制器
  TextEditingController _userController = TextEditingController();
  //密码的控制器
  TextEditingController _pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.px),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildCard()
          ],
        ),
      ),
    );
  }

  Widget buildCard() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20.px),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              buildUser(),
              buildPassword(),
              buildButton(),
              buildOther()
            ],
          ),
        ),
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
                  .then((value) => saveUserInfo(value, userVM));
            }
          },
          textColor: Colors.white,
          color: DYXColors.blue,
        ),
      ),
    );
  }

  /// 保存用户信息
  void saveUserInfo(DYXUserModel user, DYXUserViewModel userVM) {
    if(user == null) return;
    print("用户名:${user.data.userName}");
    print("用户名:${user.data.name}");
    print("用户名:${user.data.phoneNumber}");
    print("用户名:${user.data.school}");
    Navigator.pop(context);
    DYXToast.showToast("登录成功");
    userVM.user = user;
  }

  /// 其它
  Widget buildOther() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.px),
      child: DYXLoginRegisterForget(),
    );
  }
}
