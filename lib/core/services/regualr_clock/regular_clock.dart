import 'dart:ffi';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:student_management/core/model/regular/regular_search_model.dart';
import 'package:student_management/core/model/regular_clock/regular_clock_search_model.dart';
import 'package:student_management/core/services/http_request.dart';
import 'package:student_management/core/utils/date_time_utils.dart';
import 'package:student_management/core/view_model/user_view_model.dart';

class DYXRegularClockServices {
  static Future insert({
    MultipartFile image,
    String mood,
    @required int regularAddRecord
  }){
    Map<String, dynamic> t = {
      'clock_in_time': DYXDateTimeUtils.getNowTimeStamp(),
      "regular_add_record ": regularAddRecord
    };
    if(image != null) t['image'] = image;
    if(mood != null) t['mood'] = mood;
    print(DYXUserViewModel.staticToken);
    return DYXHttpRequest().request(
      "/regularClock/insert",
      method: "post",
      data: FormData.fromMap(t),
      headers: {"token": DYXUserViewModel.staticToken}
    );
  }

  /// 查询
  static Future<DYXRegularClockSearchModel> search({
    int regularAddRecordId, // 打卡项
    int clockInTime, // 时间戳
    int index = 1
  }) async{
    Map<String, dynamic> t = {
    };
    if (regularAddRecordId != null) t['regular_add_record'] = regularAddRecordId;
    if (clockInTime != null) t['clock_in_time'] = clockInTime;

    var data = await DYXHttpRequest().request(
      "/regularClock/search",
      data: FormData.fromMap(t),
      params: {
        "index":index
      },
      headers: {"token": DYXUserViewModel.staticToken}
    ).catchError((e)=>print("错误"));
    if (data == null) return null;
    return DYXRegularClockSearchModel.fromJson(data);
  }
}