import 'package:student_management/core/services/http_request.dart';

class DYXLoginRequest {
  /// 发送验证码
  static Future sendCode(String phoneNumber) {
    return DYXHttpRequest().request(
      "/user/sendCode",
      data: {"phone_number": phoneNumber},
      method: "post",
    );
  }

  /// 检测手机验证码
  static Future checkCode(String token, String phoneNumber, String code, {
    bool showErrorMessage=false,
    bool showSuccessMessage= false,
    bool showSuccessCode200Message= false
  }) async{
    return DYXHttpRequest().request(
      "/user/check_phone_code",
      data: {"phone_number": phoneNumber, "code": code},
      method: "post",
      headers: {"token": token},
      showErrorMessage: showErrorMessage,
      showSuccessMessage: showSuccessMessage,
      showSuccessCode200Message: showSuccessCode200Message
    );
  }
}