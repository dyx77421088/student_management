import 'package:flutter/material.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';

class DYXSettingContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Positioned(
            bottom: 10,
            right: 0,
            left: 0,
            child: RaisedButton(
              color: Colors.red,
              child: Text('退出登录'),
              onPressed: () {},
            ),
        ),
    );
  }
}
