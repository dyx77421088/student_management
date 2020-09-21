import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/inner_drawer/inner_drawer_utils.dart';
import 'package:student_management/ui/shared/password_verification/password_verification.dart';
import 'package:student_management/ui/shared/phone_verification/phone_verification.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';
import 'package:student_management/ui/widgets/setting_item.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/ui/widgets/shield_score.dart';
import 'package:student_management/ui/widgets/user_security_center_item.dart';

import 'click/user_security_center_update_password_by_old_password.dart';
import 'click/user_security_center_update_email.dart';
import 'click/user_security_center_update_phone.dart';

class DYXUserSecurityCenterContent extends StatefulWidget {
  @override
  _DYXUserSecurityCenterContentState createState() => _DYXUserSecurityCenterContentState();
}

class _DYXUserSecurityCenterContentState extends State<DYXUserSecurityCenterContent> {
  GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();
  num index = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer<DYXUserViewModel>(
      builder: (ctx, userVM, child) => DYXInnerDrawerUtils.buildInnerDrawer(
        context,
        key: _innerDrawerKey,
        swipe:false,
        rightAnimationType: InnerDrawerAnimation.linear,
        offset: IDOffset.only(right: 1, top: 1),
        duration: Duration(seconds: 3),
        backgroundDecoration: BoxDecoration(
          color: DYXColors.blue[50]
        ),
        innerDrawerCallback: (isOpened){
          print(isOpened);
          if(!isOpened) {
            FocusScope.of(context).requestFocus(FocusNode());
          }
        },
        scaffold: buildScaffold(userVM),
        rightChild: opRightChild(userVM, index)
      ),
    );
  }

  Widget buildScaffold(DYXUserViewModel userVM) {
    return Container(
      color: DYXColors.blue[50],
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 10.px),
        children: <Widget>[
          DYXShield(200.px, getScore(userVM)),
          buildUpdatePassword(),
          SizedBox(height: 5.px,),
          buildUpdateQQ(userVM),
          SizedBox(height: 5.px,),
          buildUpdateEmail(userVM),
          SizedBox(height: 5.px,),
          buildUpdatePhone(userVM),
        ],
      ),
    );
  }

  num getScore(DYXUserViewModel userVM) {
    num a = 25; // 密码得分
    a += userVM.qq != null ? 25 : 0;
    a += userVM.email != null ? 25 : 0;
    a += userVM.phoneNumber != null ? 25 : 0;
    return a;
  }

  /// 修改密码
  Widget buildUpdatePassword() {
    return DYXUserSecurityCenterItem(
      title: Text('设置密码'),
      leadingType: DYXUserSecurityCenterItemLeadingType.checkOk,
      subtitle: Text('已设置'),
      onTap: (){
        setState(() {
          index = 1;
        });
        _innerDrawerKey.currentState.open();
      },
    );
  }

  /// qq
  Widget buildUpdateQQ(DYXUserViewModel userVM) {
    return DYXUserSecurityCenterItem(
      title: Text('绑定QQ账号'),
      subtitle: Text(userVM.qq != null ? "已绑定QQ" : "未绑定QQ"),
      leadingType: userVM.qq != null ? DYXUserSecurityCenterItemLeadingType.checkOk : DYXUserSecurityCenterItemLeadingType.warning,
      onTap: (){
      },
      showTrailing: false,
    );
  }

  /// email
  Widget buildUpdateEmail(DYXUserViewModel userVM) {
    return DYXUserSecurityCenterItem(
      title: Text('绑定email'),
      subtitle: Text(userVM.email != null ? getEmail(userVM.email) : "未绑定email"),
      leadingType: userVM.email != null ? DYXUserSecurityCenterItemLeadingType.checkOk : DYXUserSecurityCenterItemLeadingType.warning,
      onTap: (){
        // 如果为空则可以修改
        if(userVM.email == null) {
          setState(() {
            index = 2;
          });
        }
      },
      showTrailing: userVM.email == null,
    );
  }

  /// phone
  Widget buildUpdatePhone(DYXUserViewModel userVM) {
    return DYXUserSecurityCenterItem(
      title: Text('绑定手机号'),
      subtitle: Text(userVM.phoneNumber != null ? getPhone(userVM.phoneNumber) : "未绑定手机"),
      leadingType: userVM.phoneNumber != null ? DYXUserSecurityCenterItemLeadingType.checkOk : DYXUserSecurityCenterItemLeadingType.warning,
      onTap: (){
        setState(() {
          index = 3;
        });
        _innerDrawerKey.currentState.open();
      },
    );
  }

  String getPhone(String phone) {
    return phone.replaceRange(3, 8, "*****");
  }

  String getEmail(String email) {
    return email.replaceRange(3, email.lastIndexOf("@"), "****");
  }



  /// 点击后右边的child改变
  Widget opRightChild(DYXUserViewModel userVM, num index) {
    switch(index) {
      case 1: // 修改密码
        return DYXUpdatePasswordByOldPassword(_innerDrawerKey);
      case 2: // 绑定email
        return DYXUpdatePasswordByOldPassword(_innerDrawerKey);
      case 3: // 绑定手机号的验证
        if(userVM.phoneNumber != null) { // 先验证手机
          return DYXPhoneVerification(() {
            setState(() {
              this.index = 33;
            });
          });
        } else { // 先验证密码
          return DYXPasswordVerification(() {
            setState(() {
              this.index = 33;
            });
          });
        }
        break;
      case 33: // 绑定手机号
        return DYXUserSecurityCenterUpdatePhone();
    }
    return Text('hhhhhh');
  }
}
