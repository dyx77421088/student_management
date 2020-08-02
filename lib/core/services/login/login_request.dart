import 'package:dio/dio.dart';
import 'package:student_management/core/services/http_request.dart';
import 'package:student_management/core/utils/login_utils.dart';
import 'package:student_management/ui/shared/toast/toast.dart';

class DYXLoginRequest {
  /// 发送验证码
  static void sendCode(String phoneNumber, {Function onResponse}) {
    DYXHttpRequest().request(
      "/user/sendCode",
      data: {"phone_number": phoneNumber},
      method: "post",
      inter: InterceptorsWrapper(
        // 错误拦截
        onError: (error) {
          print('错误拦截');
          print(error.response.data);
          DYXToast.showToast(error.response.data["message"]);
          return error;
        },
        // 响应拦截
        onResponse: (response) {
          print('响应拦截');
          DYXToast.showToast(response.data["message"]);
          // 响应之后执行的方法
          if (onResponse != null)
            onResponse();
          return response;
        },
      )
    );
  }
}