import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management/ui/shared/image/image_cropper/image_cropper_utils.dart';

class DYXImagePickerUtils {
  static final picker = ImagePicker();

  /// 从相机获得图片
  static Future<PickedFile> getImageByCamera() async {
    return picker.getImage(source: ImageSource.camera);
  }
  /// 从相册中选择
  static Future<PickedFile> getImageByGallery() async{
    return picker.getImage(source: ImageSource.gallery);
  }
  /// 从相机中获得图片并裁剪它
  static Future<File> getCropperImageByCamera({CropStyle cropStyle}) async{
    var image = await getImageByCamera();
    return DYXImageCropperUtils.cropImage(image.path, cropStyle: cropStyle);
  }
  /// 从相册中获得图片并裁剪它
  static Future<File> getCropperImageByGallery({CropStyle cropStyle}) async{
    var image = await getImageByGallery();
    return DYXImageCropperUtils.cropImage(image?.path, cropStyle: cropStyle);
  }
}