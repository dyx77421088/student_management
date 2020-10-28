import 'dart:ffi';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
}