import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:student_management/core/view_model/user_view_model.dart';

import '../http_request.dart';

class DYXWorkDelete {
  /// 用户详情修改
  static Future<dynamic> del({
    @required int id, // 根据id删除
  }) async{
    var data = await DYXHttpRequest().request(
      "/work/delete/$id",
      // headers: {"token": DYXUserViewModel.staticToken},
      method: "delete",
      showSuccessMessage: false
    );
    print(data);
    return data;
  }
}