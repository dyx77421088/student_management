import 'package:student_management/core/services/http_request.dart';

/// 检测手机号是否存在
class DYXUserCheckPhoneNumber {
  /// 检测手机号
  static Future checkPhoneNumber(String phoneNumber) {
    return DYXHttpRequest().request(
      "/user/checkPhoneNumber/$phoneNumber",
      method: "get",
      showSuccessMessage: false
    );
  }
}