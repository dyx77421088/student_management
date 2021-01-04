import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:student_management/core/model/regular_add_record/regular_add_record_model.dart' as regularAddRecord;
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/core/model/regular_clock/regular_clock_search_model.dart' as regularClock;
import 'package:student_management/core/services/regualr_clock/regular_clock.dart';
import 'package:student_management/core/utils/date_time_utils.dart';
import 'package:student_management/ui/shared/dialog/dialog.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/image/image_network.dart';
import 'package:student_management/ui/shared/image/image_picker/image_picker_utils.dart';
import 'package:student_management/ui/shared/image/image_show.dart';
import 'package:student_management/ui/shared/progress/progress_utils.dart';
import 'package:student_management/ui/shared/toast/toast.dart';
class A {
  void fun() {}
  void fun2(){}
  void fun3() {
    A a = new A();
    a..fun()..fun2();
    // a = null;
    var b = a?.fun(); // b = null
    var c = a??A(); // a == null ? A() : a
  }
}
class DYXRegularContentEditSetting {
  regularAddRecord.Result result;
  regularClock.Result clock;
  bool readOnly;

  DYXRegularContentEditSetting(this.result, {this.readOnly=false, this.clock});
}
class DYXRegularContentEditPage extends StatefulWidget {
  static const String routeName = "/DYXRegularContentEditPage";
  final DYXRegularContentEditSetting editSetting;

  DYXRegularContentEditPage(this.editSetting);

  @override
  _DYXRegularContentEditState createState() => _DYXRegularContentEditState();
}

class _DYXRegularContentEditState extends State<DYXRegularContentEditPage> {
  File imageFile;
  var imageKey = GlobalKey();
  var moodController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.editSetting.readOnly)
      moodController.text = widget.editSetting.clock.mood;
    return Scaffold(
      appBar: AppBar(
        title: Text("打卡${widget.editSetting.readOnly?"(${isToDay()?"今日已签到":"查看"})":""}"),
        actions: widget.editSetting.readOnly ? null : [
          FlatButton(onPressed: (){saveRegular(context);}, child: Text("保存", style: TextStyle(color: Colors.white)))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.px),
        child: Column(
          children: [
            Text("${widget.editSetting.result.regular.title}"),
            Text("${widget.editSetting.result.startTimeStr}~${widget.editSetting.result.endTimeStr}"),
            TextFormField(
              controller: moodController,
              maxLength: 120,
              maxLines: 5,
              readOnly: widget.editSetting.readOnly,
              decoration: InputDecoration(
                  helperText: "记录你的心情",
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 10.px,),
            Row(
              children: [
                widget.editSetting.clock?.image != null ?
                buildOnlyReadImage(widget.editSetting.clock.image)
                : (
                    imageFile == null ?
                    GestureDetector(
                      child: Icon(DYXIcons.add_image, size: 40.px,),
                      onTap: widget.editSetting.readOnly ? null : showSelectImageDialog,
                    )
                    : buildImage(context)
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  /// 这个打卡项是否是今日的
  bool isToDay() {
    if (widget.editSetting?.clock?.clockInTime == null) return false;
    return DYXDateTimeUtils.floorTime() == DYXDateTimeUtils.floorTime(timeStamp: widget.editSetting.clock.clockInTime);
  }

  /// 保存打卡
  void saveRegular(BuildContext context) async{
    // 显示对话框
    AwesomeDialog dialog = DYXProgressDialog.showProgressDialog(
      context: context,
      message: "正在上传...",
    )..show();

    MultipartFile image = imageFile != null ? await MultipartFile.fromFile(imageFile.path) : null;
    DYXRegularClockServices.insert(
      image: image,
      mood: moodController.text.isEmpty ? null : moodController.text,
      regularAddRecord: widget.editSetting.result.id
    ).then((value) {
      dialog.dissmiss(); // 取消对话框
      if(value["code"] == 200) DYXToast.showToast("打卡成功");
    });
  }

  /// 只读的图片
  GestureDetector buildOnlyReadImage(String imagePath) {
    print("只读的图片");
    return GestureDetector(
      child: Hero(tag: NetworkImage(imagePath),
          child: Container(child: DYXImageNetwork.network(url: imagePath), width: 50.px, height: 50.px,)
      ),
      onTap: () {
        Navigator.pushNamed(context, DYXImageShowPage.routeName, arguments: NetworkImage(imagePath));
      },
    );
  }

  /// 图片
  GestureDetector buildImage(BuildContext context) {
    print("不是的图片");
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
    AwesomeDialog(
        context: context,
        aligment: Alignment.bottomCenter,
        dialogType: DialogType.NO_HEADER,
        body: Column(
          children: [
            FlatButton(onPressed: ()async{ // 手机拍摄
              if (imageFile != null) return;
              var image = await DYXImagePickerUtils.getCropperImageByCamera(cropStyle: CropStyle.rectangle);
              setState(() {
                imageFile = image;
              });
            }, child: Text("手机拍摄")),
            FlatButton(onPressed: ()async{ // 相册选择
              if (imageFile != null) return;
              var image = await DYXImagePickerUtils.getCropperImageByGallery(cropStyle: CropStyle.rectangle);
              setState(() {
                imageFile = image;
              });
            }, child: Text("从相册选择")),
          ],
        )
    )..show();
  }
}
