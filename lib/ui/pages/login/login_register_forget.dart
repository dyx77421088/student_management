import 'package:flutter/material.dart';

class DYXLoginRegisterForget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          child: Text('现在注册'),
          onTap: () {},
        ),
        InkWell(
          child: Text('忘记密码'),
          onTap: () {},
        ),
      ],
    );
  }
}
