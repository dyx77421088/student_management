import 'package:flutter/material.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/toast/toast.dart';
import 'package:student_management/ui/widgets/my_text_form_field.dart';

/// 密码验证
class DYXPasswordVerification extends StatefulWidget {
  final Function onPressed;

  DYXPasswordVerification(this.onPressed);

  @override
  _DYXPasswordVerificationState createState() => _DYXPasswordVerificationState();
}

class _DYXPasswordVerificationState extends State<DYXPasswordVerification> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.px),
      child: Column(
        children: <Widget>[
          Text('为了您的账户安全，需要验证您的密码'),
          Form(
            key: _formKey,
            child: buildPassword(),
          ),
          buildSubmit()
        ],
      ),
    );
  }

  /// 提交按钮
  Widget buildSubmit() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.px),
      child: RaisedButton(
        child: Text('下一步'),
        onPressed: () {submit(context);},
      ),
    );
  }

  void submit(BuildContext context){
    if(_formKey.currentState.validate()) {
      if (_passwordController.text == "12345") {
        widget.onPressed();
      } else {
        DYXToast.showToast("密码错误");
      }
    }
  }

  /// 密码输入框
  Widget buildPassword() {
    return DYXTextFormField(
      controller: _passwordController,
      leftIcon: Icon(DYXIcons.password),
      isPassword: true,
      validator: (value) {
        if (value.length < 2) {
          return "密码需要大于等于2位";
        }
        return null;
      },
    );
  }
}
