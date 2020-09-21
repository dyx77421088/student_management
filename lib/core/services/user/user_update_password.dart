import 'package:flutter/material.dart';
import 'package:student_management/core/services/http_request.dart';
import 'package:student_management/ui/shared/toast/toast.dart';
class DYXUserUpdatePassword {
  static Future updatePasswordByPassword(token, oldPassword, newPassword) async{
    return DYXHttpRequest().request(
      "/user/updatePasswordByPassword",
      method: "patch",
      headers: {"token": token},
      data: {"old_password": oldPassword, "new_password": newPassword},
    );
  }
}