import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:student_management/core/services/user_details/user_details_update.dart';
import 'package:student_management/core/viewmodel/user_view_model.dart';
import 'package:student_management/ui/shared/dialog/dialog.dart';
import 'package:student_management/ui/shared/image/image_cropper/image_cropper_utils.dart';
import 'package:student_management/ui/shared/image/image_picker/image_picker_utils.dart';
import 'package:student_management/ui/shared/image/image_select_avatar.dart';
import 'package:student_management/ui/shared/toast/toast.dart';
import 'package:student_management/ui/widgets/my_text_form_field.dart';

/// 用户详情中单击头像后的监听
void clickAvatar(BuildContext context, DYXUserViewModel userVM) async{
  DYXGetImage dyxGetImage = (File image) async{
    if(image == null)
      return;
    FormData data = FormData.fromMap({
      "avatar": await MultipartFile.fromFile(image.path)
    });
    DYXUserDetailsUpdate.update( // 发送修改的请求
        token: userVM.token,
        formData: data
    ).then((value) => userVM.avatar=value['data']['avatar']);
  };
  DYXImageSelectAvatar.showSelectAvatarDialog(context, dyxGetImage);
}

class DYXSelectImage extends StatefulWidget {
  @override
  _DYXSelectImageState createState() => _DYXSelectImageState();
}

class _DYXSelectImageState extends State<DYXSelectImage> {
  File _image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton(
          child: Text('选择图片'),
          onPressed: () async{
            var pickedFile = await DYXImagePickerUtils.getImageByCamera();
            // 裁剪图片
            var p = await DYXImageCropperUtils.cropImage(pickedFile.path);
            setState(() {
              _image = File(p.path);
            });
          },
        ),
        _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ],
    );
  }
}


/// 用户详情中单击用户名后的监听
void clickNickName(BuildContext context, TextEditingController nickNameController) {
//  DYXDialog.showDialog(
//    context: context,
//    body: DYXTextFormField(controller: nickNameController,),
//    btnCancelOnPress: () {},
//    btnOkOnPress: () {
//      DYXToast.showToast("你输入的信息是${nickNameController.text}");
//    },
//  );
}

int sexInt = -2;
/// 用户详情中单击用户名后的监听
void clickSex(BuildContext context, DYXUserViewModel userVM) {
  // 初始化sex值
  sexInt = userVM.sexInt;
  DYXDialog.showDialog(
    context: context,
    body: SexRadio(),
    dialogType: DialogType.NO_HEADER,
    btnCancelOnPress: (){},
    btnOkOnPress: (){
      // 修改数据
      if(sexInt != userVM.sexInt && (sexInt == -1 || sexInt == 0 || sexInt == 1)) {
        Map<String, dynamic> map = {
          "sex": sexInt
        };
        FormData formData = FormData.fromMap(map);
        DYXUserDetailsUpdate.update(
          token: userVM.token,
          formData: formData
        ).then((value) {
          DYXToast.showToast("修改成功");
          userVM.sexInt = sexInt;
        });
      } else {
        DYXToast.showToast("出来");
      }
    },
  );
}


class SexRadio extends StatefulWidget {
  @override
  _SexRadioState createState() => _SexRadioState();
}

class _SexRadioState extends State<SexRadio> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildListTile(-1, "女"),
        buildListTile(0, "保密"),
        buildListTile(1, "男"),
      ],
    );
  }

  /// build单个radio
  Widget buildListTile(value, text) {
    return ListTile(
      leading: Radio(
        value: value,
        groupValue: sexInt,
        onChanged: (sex) {
          setState(() {
            sexInt = sex;
          });
        },
      ),
      title: Text(text),
    );
  }
}


/// 用户详情中单击生日的监听
void clickBirthday() {
  DYXToast.showToast("单击了生日设置");
}

/// 用户详情中单击个性签名的监听
void clickPersonalSignature() {
  DYXToast.showToast("单击了个性签名设置");
}