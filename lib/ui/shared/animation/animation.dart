import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class DYXAnimation{
  AnimationController controller;

  Widget animation(TickerProvider tp) {
    controller = AnimationController(vsync: tp);

  }
}