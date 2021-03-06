import 'dart:async';

import 'package:flutter/material.dart';
/// 倒计时的通知
class DYXCountDownViewModel extends ChangeNotifier {
  var _countTime1 = 0;
  Timer _timer1;
  /// 计时器1
  void startTimer1() {
    _countTime1 = 60;

    final call = (_) {
      if(_countTime1 <= 0) {
        _timer1.cancel();
      } else {
        _countTime1 -= 1;
      }
      notifyListeners();
    };
    _timer1 = Timer.periodic(Duration(seconds: 1), call);
  }

  get countTime1 => _countTime1;

  get canCountTime1 => _countTime1 <= 0;

  var _countTime2 = 0;
  Timer _timer2;
  /// 计时器2
  void startTimer2() {
    _countTime2 = 60;

    final call = (_) {
      if(_countTime2 <= 0) {
        _timer2.cancel();
      } else {
        _countTime2 -= 1;
      }
      notifyListeners();
    };
    _timer2 = Timer.periodic(Duration(seconds: 1), call);
  }

  get countTime2 => _countTime2;

  get canCountTime2 => _countTime2 <= 0;


  var _countTime3 = 0;
  Timer _timer3;
  /// 计时器3
  void startTimer3() {
    _countTime3 = 60;

    final call = (_) {
      if(_countTime3 <= 0) {
        _timer3.cancel();
      } else {
        _countTime3 -= 1;
      }
      notifyListeners();
    };
    _timer3 = Timer.periodic(Duration(seconds: 1), call);
  }

  get countTime3 => _countTime3;

  get canCountTime3 => _countTime3 <= 0;
}