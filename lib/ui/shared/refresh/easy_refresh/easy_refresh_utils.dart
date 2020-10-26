import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class DYXEasyRefreshUtils {
  static Widget custom ({
    Function onRefresh,
    Function onLoad,
    List<Widget> slivers
  }) => EasyRefresh.custom(
    header: MaterialHeader(),
    footer: MaterialFooter(),
    onRefresh: () async {
      await Future.delayed(Duration(seconds: 2), () {
        onRefresh();
      });
    },
    onLoad: () async {
      await Future.delayed(Duration(seconds: 2), () {
        onLoad();
      });
    },
    slivers: slivers,
  );
}