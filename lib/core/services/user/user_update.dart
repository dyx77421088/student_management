import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:student_management/core/services/http_request.dart';
import 'package:student_management/ui/shared/toast/toast.dart';
class DYXUserUpdate {
  /// 用户修改密码
  static Future updatePasswordByPassword(token, oldPassword, newPassword) async{
    return DYXHttpRequest().request(
      "/user/updatePasswordByPassword",
      method: "patch",
      headers: {"token": token},
      data: {"old_password": oldPassword, "new_password": newPassword},
    );
  }

  /// 用户修改手机号
  static Future updatePhoneNumber(token, phoneNumber) {
    FormData formData = FormData.fromMap({
      "phone_number": phoneNumber
    });
    return DYXHttpRequest().request(
      "/user/update_phone",
      method: "patch",
      headers: {"token": token},
      data: formData,
    );
  }
}