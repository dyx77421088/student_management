import 'package:flutter/material.dart';
import 'package:student_management/ui/shared/icon/icons.dart';

//验证信息
typedef String MyValidator(String value);

class DYXTextFormField extends StatefulWidget {
  //是否为password
  final bool isPassword;

  //标签
  final String labelText;

  //错误信息
  final String errorText;

  //提示信息
  final String hintText;

  //控制器
  final TextEditingController controller;

  //最大长度
  final int maxLength;

  //左边的图标
  final Widget leftIcon;

  // 后缀图标
  final Widget suffixIcon;

  // 验证信息
  final MyValidator validator;

  // 焦点
  final FocusNode focusNode;

  DYXTextFormField(
      {this.leftIcon,
      this.maxLength = 20,
      @required this.controller,
      this.labelText,
      this.errorText,
      this.hintText,
      this.isPassword = false,
      this.suffixIcon,
      this.validator,
      this.focusNode
      });

  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<DYXTextFormField> {
  //是否输入了文字
  bool _haveText = false;

  //password的切换   false:不显示， true显示
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    //如果 isPassword=true 就不显示密码，否则就显示密码
    _passwordVisible = !widget.isPassword;
  }

  //单击清空按钮
  void _onClear() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.controller.clear());
    setState(() {
      _haveText = false;
    });
  }

  //单击查看密码按钮
  void _onShowPassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      maxLength: widget.maxLength,
      //设置是否为密码输入
      obscureText: !_passwordVisible,
      decoration: buildInputDecoration(),
      //验证信息
      validator: widget.validator ?? pwdValidator,
      //验证成功后执行，保存值
      onSaved: (value) => print('这个监听中的值$value'),
      onChanged: (value) {
        if (_haveText != value.length > 0) {
          setState(() {
            _haveText = value.length > 0;
          });
        }
      },
//      focusNode: ,
    );
  }

  /// 装饰
  InputDecoration buildInputDecoration() {
    return InputDecoration(
      hintText: widget.hintText,
      prefixIcon: widget.leftIcon ?? Icon(DYXIcons.account),
      suffixIcon: widget.suffixIcon ?? buildSuffixIcon(),
      labelText: widget.labelText,
    );
  }

  /// 后缀图标
  Container buildSuffixIcon() {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _haveText
              ? IconButton(
                  icon: Icon(DYXIcons.close),
                  onPressed: this._onClear,
                )
              : Text(''),
          widget.isPassword
              ? IconButton(
                  icon: Icon(_passwordVisible
                      ? DYXIcons.visibility_off
                      : DYXIcons.visibility),
                  onPressed: this._onShowPassword,
                )
              : Text(''),
        ],
      ),
    );
  }

  String pwdValidator(String value) {
    if (value == null || value.isEmpty || value.trim().length < 6) {
      if(widget.isPassword) {
        return "密码需要大于6位";
      }
      if(value.trim().length < 2)
        return "用户名需要大于等于2位";
    }
    return null;
  }
}
