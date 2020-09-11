import 'package:dio/dio.dart';
import 'package:student_management/core/model/user/user_parent_login_model.dart';
import 'package:student_management/core/model/user/user_student_login_model.dart';
import 'package:student_management/core/model/user/user_teacher_login_model.dart';
import 'package:student_management/core/services/http_request.dart';
import 'package:student_management/core/model/user/user_login_model.dart';

class DYXUserRequest {
  /// 用户登录
  static Future<DYXUserLoginModel> onUserLogin(String userName, String password) async{
    final user = await DYXHttpRequest().request(
      "/user/login",
      data: {"user_name": userName, "password": password},
      method: "post",
    );
    return saveInfo(user);
  }

  /// 手机号登录
  static Future<DYXUserLoginModel> onPhoneLogin(String phoneNumber, String code) async{
    final user = await DYXHttpRequest().request(
        "/user/loginPhoneNumber",
        data: {"phone_number": phoneNumber, "code": code},
        method: "post",
    );

    return saveInfo(user);
  }

  /// token自动登录
  static Future<DYXUserLoginModel> onToken(String token, {Interceptor inter}) async{
    final user = await DYXHttpRequest().request(
      "/user/loginToken",
      headers: {"token": token},
      method: "post",
      inter: inter
    );

    return saveInfo(user);
  }

  /// 根据role（角色）来保存角色信息
  static DYXUserLoginModel saveInfo(user) {
    switch(user['data']['role']) {
      /// 老师或辅导员
      case 0:case 3: return DYXUserTeacherLoginModel.fromJson(user);
      /// 学生
      case 1: return DYXUserStudentLoginModel.fromJson(user);
      /// 家长
      case 2: return DYXUserParentLoginModel.fromJson(user);
    }
    return null;
  }
}