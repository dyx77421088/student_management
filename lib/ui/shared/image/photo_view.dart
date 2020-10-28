import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

/// 照片查看器
class DYXPhotoViewUtils {
  static Widget basic({@required ImageProvider imageProvider}) => Container(
    width: 50,
    height: 50,
    child: PhotoView(
      imageProvider: imageProvider,
      heroAttributes: PhotoViewHeroAttributes(tag: imageProvider),
      maxScale: 3.0,
      minScale: 0.1,
    )
  );
}