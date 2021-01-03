import 'package:flutter/material.dart';
import 'package:student_management/ui/shared/image/image_asset.dart';
import 'package:student_management/core/extension/int_extension.dart';
/// 空白页显示
enum DYXBlankType {
  tuzi, // 兔子
  boy, // 小男孩
  pkq, // 皮卡丘
}
class DYXBlankPage extends StatelessWidget {
  final String text;
  final DYXBlankType imageType;
  final ImageProvider image;

  DYXBlankPage({this.text="什么都还没有...", this.imageType=DYXBlankType.boy, this.image})
    :assert(imageType!=null || image!=null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          image ?? DYXImageAsset(toImagePath(imageType), color: null,),
          SizedBox(height: 10.px,),
          Text(text, style: TextStyle(color: Colors.black, fontSize: 16.px),)
        ],
      ),
    );
  }

  String toImagePath(DYXBlankType type) {
    switch(type) {
      case DYXBlankType.boy:
        return "boy.jpg";
      case DYXBlankType.tuzi:
        return "tuzi.png";
      case DYXBlankType.pkq:
        return "pkq.png";
    }
    return "boy";
  }
}
