import 'package:dio/dio.dart';
import 'package:student_management/core/model/user_details/user_details_model.dart';
import 'package:student_management/core/services/http_request.dart';
import 'package:student_management/core/model/user/user_model.dart';
import 'package:student_management/ui/shared/toast/toast.dart';

class DYXUserRequest {
  /// 用户登录
  static Future<DYXUserModel> onUserLogin(String userName, String password) async{
    final user = await DYXHttpRequest().request(
      "/user/login",
      data: {"user_name": userName, "password": password},
      method: "post",
    );

    DYXUserModel userInfo = DYXUserModel.fromJson(user);

    // 获得用户详情
    final userDetails = await DYXHttpRequest().request(
      "/userDetails/getUserDetailsByToken",
      headers: {"token": userInfo.data.token},
      method: "get",
    );
    // 设置用户详情
    userInfo.userDetails = DYXUserDetailsModel.fromJson(userDetails);

    return userInfo;
  }

  /// 手机号登录
  static Future<DYXUserModel> onPhoneLogin(String phoneNumber, String code) async{
    final user = await DYXHttpRequest().request(
        "/user/loginPhoneNumber",
        data: {"phone_number": phoneNumber, "code": code},
        method: "post",
    );

    DYXUserModel userInfo = DYXUserModel.fromJson(user);

    // 获得用户详情
    final userDetails = await DYXHttpRequest().request(
      "/userDetails/getUserDetailsByToken",
      headers: {"token": userInfo.data.token},
      method: "get",
    );
    // 设置用户详情
    userInfo.userDetails = DYXUserDetailsModel.fromJson(userDetails);

    return userInfo;
  }

  /// token自动登录
  static Future<DYXUserModel> onToken(String token) async{
    final user = await DYXHttpRequest().request(
      "/user/loginToken",
      headers: {"token": token},
      method: "post",
    );

    DYXUserModel userInfo = DYXUserModel.fromJson(user);

    // 获得用户详情
    final userDetails = await DYXHttpRequest().request(
      "/userDetails/getUserDetailsByToken",
      headers: {"token": token},
      method: "get",
    );
    // 设置用户详情
    userInfo.userDetails = DYXUserDetailsModel.fromJson(userDetails);

    return userInfo;
  }
}