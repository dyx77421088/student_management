import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:student_management/ui/shared/dialog/dialog.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';

import 'image_cropper/image_cropper_utils.dart';
import 'image_picker/image_picker_utils.dart';
import 'package:student_management/core/extension/int_extension.dart';

File _image;
typedef void DYXGetImage(File image);
/// 选取头像
class DYXImageSelectAvatar {
  static void showSelectAvatarDialog(BuildContext context, DYXGetImage dyxGetImage){
    _image = null;
    // 展示选择头像的对话框
    DYXDialog.showDialog(
      context: context,
      dialogType: DialogType.NO_HEADER,
      body: DYXSelectImage(),
      btnOkOnPress: () {dyxGetImage(_image);},
      btnCancelOnPress: () {},
      animType: AnimType.TOPSLIDE
    );
  }
}

class DYXSelectImage extends StatefulWidget {
  @override
  _DYXSelectImageState createState() => _DYXSelectImageState();
}

class _DYXSelectImageState extends State<DYXSelectImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _image == null ? Text('No image selected.') : buildAvatarImage(),
        MaterialButton(
          child: Text('相机拍摄'),
          onPressed: () async{
            // 获得相机中拍摄的图片并裁剪它
            var image = await DYXImagePickerUtils.getCropperImageByCamera();
            setState(() {
              _image = image == null ? null : File(image.path);
            });
          },
        ),
        MaterialButton(
          child: Text('从相册中选择'),
          onPressed: () async{
            // 获得相册中选择的图片并裁剪它
            var image = await DYXImagePickerUtils.getCropperImageByGallery();
            setState(() {
              _image = image == null ? null : File(image.path);
            });
          },
        ),
      ],
    );
  }

  Widget buildAvatarImage() {
    return Container(
      width: 100.px,
      height: 100.px,
      child: CircleAvatar(
        backgroundImage: FileImage(_image),
      ),
    );
  }
}