import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/services/login/login_request.dart';
import 'package:student_management/core/services/user/user_check.dart';
import 'package:student_management/core/services/user/user_update.dart';
import 'package:student_management/core/utils/login_utils.dart';
import 'package:student_management/core/view_model/count_down_view_model.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/toast/toast.dart';
import 'package:student_management/ui/widgets/my_text_form_field.dart';

/// 修改phoneNumber
class DYXUserSecurityCenterUpdatePhone extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<DYXUserViewModel>(
      builder: (ctx, userVM, child) => Container(
        padding: EdgeInsets.all(20.px),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              buildPhoneNumber(),
              buildCode(),
              SizedBox(height: 20.px,),
              buildSubmit(context, userVM)
            ],
          ),
        ),
      ),
    );
  }

  /// 提交按钮
  Widget buildSubmit(BuildContext context, DYXUserViewModel userVM) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.px),
      child: RaisedButton(
        child: Text('确定'),
        onPressed: (){
          // 修改手机号
          updatePhone(context, userVM);
        },
      ),
    );
  }

  /// 修改手机号
  void updatePhone(BuildContext context, DYXUserViewModel userVM) async{
    if(formKey.currentState.validate()) {
      // 验证手机验证码
      var request = await DYXLoginRequest.checkCode(
        userVM.token,
        _phoneController.text,
        _codeController.text,
        showSuccessMessage: true
      );
      if (request['code'] == 200) { // 成功
        // 检测手机号是否已经注册
        DYXUserCheck.checkPhoneNumber(_phoneController.text).then((value){
          if(value['phone_number_status'] == 1) {
            DYXToast.showToast("手机已经被注册!!");
          } else { // 修改用户的手机号
            DYXUserUpdate.updatePhoneNumber(userVM.token, _phoneController.text).then((value) {
              if(value['code'] == 200) {
                userVM.phoneNumber = _phoneController.text;
                // 退出
                Navigator.pop(context);
              }
            });

          }
        });
      }

//      DYXToast.showToast("修改成功");
//      Navigator.pop(context);
    }
  }

  /// 验证码
  Widget buildCode() {
    return Consumer<DYXCountDownViewModel>(
      builder: (ctx, cdVM, child) => DYXTextFormField(
        controller: _codeController,
        leftIcon: Icon(DYXIcons.code),
        maxLength: 6,
        hintText: "验证码",
        validator: (value) {
          if (value == null || value.length <= 0) {
            return "验证码不能为空";
          }
          return null;
        },
        suffixIcon: FlatButton(
          child: Text(cdVM.canCountTime3 ? '获得验证码' : "${cdVM.countTime3}秒后重试"),
          onPressed: cdVM.canCountTime3 ?  () {sendCode(cdVM);} : null,
        ),
      ),
    );
  }

  /// 发送验证码
  void sendCode(DYXCountDownViewModel cdVM) {
    if (!DYXLoginUtils.checkPhoneNumber(_phoneController.text)) {
      DYXToast.showToast("手机号格式错误");
      return;
    }
    DYXLoginRequest.sendCode(_phoneController.text).then((value){
      if(value['code'] == 200) {
        cdVM.startTimer3();
      }
    });

  }

  /// 手机号
  Widget buildPhoneNumber() {
    return DYXTextFormField(
      controller: _phoneController,
      leftIcon: Icon(DYXIcons.phone),
      hintText: "新的手机号",
      validator: (String value) {
        if(!DYXLoginUtils.checkPhoneNumber(value)) {
          return "手机格式错误";
        }
        return null;
      },
    );
  }
}
