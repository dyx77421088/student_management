import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/services/login/login_request.dart';
import 'package:student_management/core/view_model/count_down_view_model.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/ui/shared/pin_code_fields/pin_code_fields_utils.dart';
import 'package:student_management/ui/shared/toast/toast.dart';


/// 手机验证
class DYXPhoneVerification extends StatefulWidget {
  final Function onPressed;

  DYXPhoneVerification(this.onPressed);

  @override
  _DYXPhoneVerificationState createState() => _DYXPhoneVerificationState();
}

class _DYXPhoneVerificationState extends State<DYXPhoneVerification> {
  bool enabled = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<DYXUserViewModel>(
      builder: (ctx, userVM, child) => Container(
        padding: EdgeInsets.all(10.px),
        child: Column(
          children: <Widget>[
            Icon(DYXIcons.phone_iphone, size: 100.px,),
            SizedBox(height: 20.px,),
            Text('为了您的账户安全，需要验证您的手机'),
            Text(getPhone(userVM.phoneNumber)),
            SizedBox(height: 20.px,),
            buildPhoneCode(context, userVM),
            buildSendCode(userVM)
          ],
        ),
      ),
    );
  }

  /// 发送验证码
  Widget buildSendCode(DYXUserViewModel userVM) {
    return Consumer<DYXCountDownViewModel>(
      builder: (ctx, cdVM, child) => Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.px),
        child: RaisedButton(
          child: Text(cdVM.canCountTime2 ? '发送验证码' : "${cdVM.countTime2}秒后重试"),
          onPressed: cdVM.canCountTime2 ? (){
            // 开始计时器
            cdVM.startTimer2();
            DYXLoginRequest.sendCode(userVM.phoneNumber).then((value){
              if (!enabled) {
                setState(() {
                  enabled = !enabled;
                });
              }
            });
          } : null,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    errorController.close();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
  final formKey = GlobalKey<FormState>();

  /// 获得验证码
  Widget buildPhoneCode(BuildContext context, DYXUserViewModel userVM) => Form(
    key: formKey,
    child: DYXPinCodeFieldsUtils.buildPinCodeFields(
      key: scaffoldKey,
      errorAnimationController: errorController,
      context: context,
      length: 6,
      enabled: enabled,
      onChanged: (_){},
      onCompleted: (String code) {
        DYXLoginRequest.checkCode(userVM.phoneNumber, code).then((value){
          if (value['code'] == 200) {
            DYXToast.showToast("成功");
            // 调用回调方法
            widget.onPressed();
          } else {
            errorController.add(ErrorAnimationType.shake);
            DYXToast.showToast("验证码错误");
          }
        });
      },
      dialogConfig: DialogConfig(
        affirmativeText: "确定",
        dialogContent: "是否粘贴",
        negativeText: "取消",
        dialogTitle: "粘贴",
      ),

    ),
  );

  String getPhone(String phone) {
    return phone.replaceRange(3, 8, "*****");
  }
}
