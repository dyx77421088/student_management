import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:student_management/core/view_model/user_view_model.dart';

import '../http_request.dart';

class DYXWorkInsert {
  /// 用户详情修改
  static Future<dynamic> insert({
    @required String course, // 作业课程科目
    @required String title , // 作业标题
    @required String content , // 作业内容
    @required int releaseTime , // 作业发布日期时间
    @required int startDate, // 作业开始时间
    @required int endDate , // 作业结束时间
    File file , // 文件
    String request, // 要求
    @required int teacher, // teacher ID
    @required int clazz, // class的id
  }) async{
    // 传数据
    Map<String, dynamic> d = {
      "course":course,
      "title":title,
      "content":content,
      "release_Time":releaseTime,
      "start_date":startDate,
      "end_date":endDate,
      "teacher ":teacher,
      "clazz": clazz,
    };
    if (file != null) {
      d['file'] = file;
    }
    if (request != null) {
      d['request'] = request;
    }

    var data = await DYXHttpRequest().request(
      "/work/insert",
      headers: {"token": DYXUserViewModel.staticToken},
      method: "post",
      data: FormData.fromMap(d),
    );
    print(data);
    return data;
  }
}