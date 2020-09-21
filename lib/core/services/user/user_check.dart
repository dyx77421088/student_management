import 'package:student_management/core/services/http_request.dart';

/// 检测手机号是否存在
class DYXUserCheck {
  /// 检测手机号
  static Future checkPhoneNumber(String phoneNumber) {
    return DYXHttpRequest().request(
      "/user/checkPhoneNumber/$phoneNumber",
      method: "get",
      showSuccessMessage: false
    );
  }

  static Future checkPassword(String token, String password) {
    return DYXHttpRequest().request(
        "/user/check_password",
        method: "post",
        data: {"password": password},
        headers: {"token": token},
        showSuccessCode200Message: false
    );
  }
}