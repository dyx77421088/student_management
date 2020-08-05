import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/core/viewmodel/user_view_model.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/image/image_network.dart';
import 'package:student_management/ui/shared/toast/toast.dart';
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
              buildAvatarSetting(context, userVM, () {
                DYXToast.showToast("单击了头像设置");
              }),
              DYXSettingItem(
                title: "昵称",
                trailing: buildTrailing(userVM.userName),
                onPressed: (){},
              ),
              DYXSettingItem(
                title: "性别",
                trailing: buildTrailing(userVM.sex),
                onPressed: (){},
              ),
              DYXSettingItem(
                title: "出生年月",
                trailing: buildTrailing(userVM.birthday ?? "无"),
                onPressed: (){},
              ),
              DYXSettingItem(
                title: "个性签名",
                trailing: buildTrailing(userVM.personalSignature ?? "无"),
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
    );
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

  Widget buildAvatarImg(DYXUserViewModel userVM) {
    return DYXImageNetwork.avatarNetwork(url: userVM.avatar);
  }

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
