import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:student_management/core/extension/int_extension.dart';

/// 修改email
class DYXUserSecurityCenterUpdateEmail extends StatelessWidget {
  final GlobalKey<InnerDrawerState> _innerDrawerKey;


  DYXUserSecurityCenterUpdateEmail(this._innerDrawerKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("请在web端进行修改或联系管理员", style: TextStyle(fontSize: 20.px),),
      ),
    );
  }
}
