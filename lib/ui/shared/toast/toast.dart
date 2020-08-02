import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DYXToast {
  static void showToast(message,
      {gravity = ToastGravity.BOTTOM,
      Color backgroundColor = Colors.grey,
      Color textColor = Colors.white}) {
    Fluttertoast.showToast(
//      child: _getToast(message, color: color, fontColor: Colors.white),
        msg: message,
        gravity: gravity,
        backgroundColor: backgroundColor,
        textColor: textColor);
  }
}
