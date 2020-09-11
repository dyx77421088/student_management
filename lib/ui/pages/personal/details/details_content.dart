import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/core/viewmodel/user_view_model.dart';
import 'package:student_management/ui/shared/dialog/dialog.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/image/image_network.dart';
import 'package:student_management/ui/shared/toast/toast.dart';
import 'package:student_management/ui/widgets/my_text_form_field.dart';
import 'package:student_management/ui/widgets/setting_item.dart';

class DYXDetailsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.px),
      child: Consumer<DYXUserViewModel>(
        builder: (ctx, userVM, child) => SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildAvatar(context, userVM),
              buildNickName(context, userVM),
              buildSex(userVM),
              buildBirthday(userVM),
              buildPersonalSignature(userVM),
            ],
          ),
        ),
      ),
    );
  }

  /// 个性签名
  DYXSettingItem buildPersonalSignature(DYXUserViewModel userVM) {
    return DYXSettingItem(
      title: "个性签名",
      trailing: buildTrailing(userVM.personalSignature ?? "无"),
      onPressed: (){},
    );
  }

  /// 生日
  DYXSettingItem buildBirthday(DYXUserViewModel userVM) {
    return DYXSettingItem(
      title: "出生年月",
      trailing: buildTrailing(userVM.birthday ?? "无"),
      onPressed: (){},
    );
  }

  /// 性别
  DYXSettingItem buildSex(DYXUserViewModel userVM) {
    return DYXSettingItem(
      title: "性别",
      trailing: buildTrailing(userVM.sex ?? "未知"),
      onPressed: (){},
    );
  }

  /// 昵称
  DYXSettingItem buildNickName(BuildContext context, DYXUserViewModel userVM) {
    TextEditingController nickNameController = TextEditingController();
    nickNameController.text = userVM.userName;

    return DYXSettingItem(
      title: "昵称",
      trailing: buildTrailing(userVM.userName),
      onPressed: (){
        DYXDialog.showDialog(
          context: context,
          body: DYXTextFormField(controller: nickNameController,),
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            DYXToast.showToast("你输入的信息是${nickNameController.text}");
          },
        );
      },
    );
  }

  /// 头像
  Widget buildAvatar(BuildContext context, DYXUserViewModel userVM) {
    return buildAvatarSetting(context, userVM, () {
      DYXToast.showToast("单击了头像设置");
    });
  }

  /// 头像
  Widget buildAvatarSetting(BuildContext context, DYXUserViewModel userVM, onPressed) {
    return Container(
      height: 80.px,
      child: RaisedButton(
          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
          color: Theme.of(context).dialogBackgroundColor,
          child: Row(
            children: <Widget>[
              Expanded(child: Text("头像", style: Theme.of(context).textTheme.subtitle1,)),
              Container(width: 60.px, height : 60.px, child: buildAvatarImg(userVM),),
              SizedBox(width: 10.px,),
              Icon(Icons.chevron_right)
            ],
          ),
          onPressed: onPressed),
    );
  }

  /// 头像图片
  Widget buildAvatarImg(DYXUserViewModel userVM) {
    if (userVM.avatar != null) {
      return DYXImageNetwork.avatarNetwork(url: userVM.avatar);
    }
    return CircleAvatar(
      backgroundImage: AssetImage("assets/images/avatar_unlogin.png"),
      backgroundColor: Colors.white,
    );
  }

  /// 后面的widget 包括  文字 + >
  Widget buildTrailing(String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(title),
        SizedBox(width: 5.px,),
        Icon(DYXIcons.chevron_right)
      ],
    );
  }
}
