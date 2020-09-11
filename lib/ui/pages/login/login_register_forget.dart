import 'package:flutter/material.dart';

class DYXLoginRegisterForget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          child: Text('现在注册'),
          onPressed: null,
        ),
        FlatButton(
          child: Text('忘记密码'),
          onPressed: () {},
        ),
      ],
    );
  }
}
