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
  static Future checkCode(String phoneNumber, String code) async{
    var a = {
      "code": 400
    };
    if(code == "903361") {
      a['code'] = 200;
      return a;
    }
    return a;
//    return DYXHttpRequest().request(
//      "/user/sendCode",
//      data: {"phone_number": phoneNumber},
//      method: "post",
//    );
  }
}