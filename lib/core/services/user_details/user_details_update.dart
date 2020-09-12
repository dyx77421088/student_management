import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:student_management/core/services/http_request.dart';

class DYXUserDetailsUpdate {
  /// 用户详情修改
  static Future<dynamic> update({
    @required String token,
    @required FormData formData
  }) async{
    var data = await DYXHttpRequest().request(
      "/userDetails/update",
        headers: {"token": token},
        method: "patch",
        data: formData
    );
    return data;
  }
}