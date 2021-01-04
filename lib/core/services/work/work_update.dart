import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:student_management/core/model/work/work_search.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/shared/toast/toast.dart';

import '../http_request.dart';

class DYXWorkUpdate {
  /// 查看作业
  static Future<DYXWorkSearchModel> search({
    @required int id,
    String course, // 作业课程科目
    String title , // 作业标题
    String content , // 作业内容
    int releaseTime , // 作业发布日期时间
    int startDate, // 作业开始时间
    int endDate , // 作业结束时间
    File file , // 文件
    String request, // 要求
  }) async{
    Map<String, dynamic> d = {};
    if (course != null) d['course'] = course;
    if (title != null) d['title'] = title;
    if (content != null) d['content'] = content;
    if (releaseTime != null) d['release_Time'] = releaseTime;
    if (startDate != null) d['start_date'] = startDate;
    if (endDate != null) d['end_date'] = endDate;
    if (file != null) d['file'] = file;
    if (request != null) d['request'] = request;

    var data = await DYXHttpRequest().request(
      "/work/update/$id",
      headers: {"token": DYXUserViewModel.staticToken},
      method: "patch",
      showSuccessMessage: false,
    );
    print(data);
    return DYXWorkSearchModel.fromJson(data);
  }
}