import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/model/user/user_model.dart';
import 'package:student_management/core/services/login/login_request.dart';
import 'package:student_management/core/services/user/user_request.dart';
import 'package:student_management/core/utils/login_utils.dart';
import 'package:student_management/core/viewmodel/count_down_view_model.dart';
import 'package:student_management/core/viewmodel/user_view_model.dart';
import 'package:student_management/ui/pages/login/login_register_forget.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/image_asset.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';
import 'package:student_management/ui/shared/toast/toast.dart';
import 'package:student_management/ui/widgets/my_text_form_field.dart';
import 'package:student_management/core/extension/int_extension.dart';

import 'package:flutter_icons/flutter_icons.dart';

class DYXLoginPhone extends StatefulWidget {
  @override
  _DYXLoginUserState createState() => _DYXLoginUserState();
}

class _DYXLoginUserState extends State<DYXLoginPhone> {
  //表单中的key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //手机号的控制器
  TextEditingController _phoneController = TextEditingController();
  //验证码的控制器
  TextEditingController _codeController = TextEditingController();

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

  /// 登录的详细信息
  Widget buildCard() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20.px),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              buildPhone(),
              buildCode(),
              buildButton(),
              buildOther()
            ],
          ),
        ),
      ),
    );
  }

  /// 手机号
  Widget buildPhone() {
    return DYXTextFormField(
      leftIcon: Icon(DYXIcons.phone),
      labelText: "手机号",
      controller: _phoneController,
      validator: (phoneNumber) { // 检测手机号是否合法
        if (!DYXLoginUtils.checkPhoneNumber(phoneNumber)) {
          return "手机号格式不正确";
        }
        return null;
      },
    );
  }

  /// 验证码
  Widget buildCode() {
    return DYXTextFormField(
      leftIcon: Icon(DYXIcons.code),
      labelText: "验证码",
      controller: _codeController,
      maxLength: 6,
      suffixIcon: buildGetCode(),
      validator: (String value) {
        return value.trim().length <= 0 ? "验证码不能为空" : null;
      },
    );
  }
  
  /// 获得验证码的按钮
  Widget buildGetCode() {
    return Consumer<DYXCountDownViewModel>(
      builder: (ctx, countVM, child) => FlatButton(
        child: Text(countVM.canCountTime1 ? "获得验证码" : "${countVM.countTime1}秒后重试"),
        onPressed: countVM.canCountTime1 ? () => sendCode(countVM) : null,
      ),
    );
  }

  /// 发送验证码
  void sendCode(DYXCountDownViewModel countVM){
    // 检测手机号是否和法
    if (!DYXLoginUtils.checkPhoneNumber(_phoneController.text)) {
      DYXToast.showToast("手机号不合法");
      return;
    }
    // 发送验证码
    DYXLoginRequest.sendCode(_phoneController.text, onResponse: () {
      // 开始倒计时
      if (countVM.canCountTime1) {
        countVM.startTimer1();
      }
    });
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
              DYXUserRequest.onPhoneLogin(_phoneController.text, _codeController.text)
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

  Widget buildOther() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.px),
      child: DYXLoginRegisterForget(),
    );
  }
}
