import 'package:flutter/material.dart';
import 'package:student_management/ui/shared/image/photo_view.dart';

class DYXImageShowPage extends StatefulWidget {
  static const String routeName = "/DYXImageShowPage";
  final ImageProvider imageProvider;

  DYXImageShowPage(this.imageProvider);

  @override
  _DYXImageShowState createState() => _DYXImageShowState();
}

class _DYXImageShowState extends State<DYXImageShowPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: DYXPhotoViewUtils.basic(imageProvider: widget.imageProvider),
      onTap: () {Navigator.pop(context);},
    );
  }
}
