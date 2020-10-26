
import 'package:flutter/material.dart';
import 'package:student_management/ui/shared/animation/flare_status.dart';
/// 登录注册中熊的状态
class DYXFlareTeddyViewModel extends ChangeNotifier {
  String _animation = DYXTeddy.idle;

  String get animation => _animation;

  set animation(String value) {
    _animation = value;
    notifyListeners();
  }
}