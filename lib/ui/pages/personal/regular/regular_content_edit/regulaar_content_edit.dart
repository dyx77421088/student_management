import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:student_management/core/model/regular_add_record/regular_add_record_model.dart' as regularAddRecord;
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/core/services/regualr_clock/regular_clock.dart';
import 'package:student_management/ui/shared/dialog/dialog.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/image/image_picker/image_picker_utils.dart';
import 'package:student_management/ui/shared/image/image_show.dart';
import 'package:student_management/ui/shared/toast/toast.dart';

class DYXRegularContentEditPage extends StatefulWidget {
  static const String routeName = "/DYXRegularContentEditPage";
  final regularAddRecord.Result result;

  DYXRegularContentEditPage(this.result);

  @override
  _DYXRegularContentEditState createState() => _DYXRegularContentEditState();
}

class _DYXRegularContentEditState extends State<DYXRegularContentEditPage> {
  File imageFile;
  var imageKey = GlobalKey();
  var moodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("打卡"),
        actions: [
          FlatButton(onPressed: saveRegular, child: Text("保存", style: TextStyle(color: Colors.white)))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.px),
        child: Column(
          children: [
            Text("${widget.result.regular.title}"),
            Text("${widget.result.startTimeStr}~${widget.result.endTimeStr}"),
            TextFormField(
              controller: moodController,
              maxLength: 120,
              maxLines: 5,
              decoration: InputDecoration(
                  helperText: "记录你的心情",
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 10.px,),
            Row(
              children: [
                imageFile == null ? GestureDetector(
                  child: Icon(DYXIcons.add_image, size: 40.px,),
                  onTap: showSelectImageDialog,
                ) : buildImage(context)
              ],
            )
          ],
        ),
      ),
    );
  }

  /// 保存打卡
  void saveRegular() async{

    MultipartFile image = imageFile != null ? await MultipartFile.fromFile(imageFile.path) : null;
    DYXRegularClockServices.insert(
      image: image,
      mood: moodController.text.isEmpty ? null : moodController.text,
      regularAddRecord: widget.result.id
    ).then((value) {
      if(value["code"] == 200) DYXToast.showToast("打卡成功");
    });
  }

  /// 图片
  GestureDetector buildImage(BuildContext context) {
    return GestureDetector(
      key: imageKey,
      child: Hero(tag: FileImage(imageFile), child: Image.file(imageFile, width: 50.px, height: 50.px,)),
      onTap: () {
        Navigator.pushNamed(context, DYXImageShowPage.routeName, arguments: FileImage(imageFile));
      },
      onLongPress: () { // 长按
        print("长按");
        PopupMenu(
          context: context,
          maxColumn: 1,
          items: [
            MenuItem(title: '删除', image: Icon(Icons.delete, color: Colors.white,)),
          ],
          onClickMenu: (MenuItemProvider item) {
            clickDel(context);
          },
        )..show(widgetKey: imageKey);
      },
    );
  }

  void clickDel(BuildContext context) {
    DYXDialog.showDialog(
      context: context,
      dialogType: DialogType.INFO,
      desc: "是否删除",
      btnOkOnPress: (){
        setState(() {
          imageFile = null;
        });
      },
      btnCancelOnPress: (){}
    );
  }

  /// 从相册选择或者手机拍摄选择照片
  void showSelectImageDialog() {
    DYXDialog.showDialog(
        context: context,
        alignment: Alignment.bottomCenter,
        dialogType: DialogType.NO_HEADER,
        body: Column(
          children: [
            FlatButton(onPressed: ()async{ // 手机拍摄
              var image = await DYXImagePickerUtils.getCropperImageByCamera(cropStyle: CropStyle.rectangle);
              setState(() {
                imageFile = image;
              });
            }, child: Text("手机拍摄")),
            FlatButton(onPressed: ()async{ // 相册选择
              var image = await DYXImagePickerUtils.getCropperImageByGallery(cropStyle: CropStyle.rectangle);
              setState(() {
                imageFile = image;
              });
            }, child: Text("从相册选择")),
          ],
        )
    );
  }
}
