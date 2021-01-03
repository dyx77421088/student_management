import 'package:flutter/material.dart';
import 'package:student_management/core/extension/int_extension.dart';

class DYXImageAsset extends Image{
  DYXImageAsset(String name, {color=Colors.black}):
      super.asset("assets/images/$name", color: color);

  DYXImageAsset.png(String name):
        super.asset("assets/images/$name.png");

  DYXImageAsset.jpg(String name):
        super.asset("assets/images/$name.jpg");

  static Widget buildIcon(String name){
    return Container(
      width: 5.px,
      height: 5.px,
      child: Center(
        child: Image.asset("assets/images/$name", fit: BoxFit.fitWidth, width: 24.px, height: 24.px,)
      ),
    );
  }
}