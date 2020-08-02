class DYXLoginUtils {
  /// 检测手机号是否合法
  static bool checkPhoneNumber(String phoneNumber) {
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(166)|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    return exp.hasMatch(phoneNumber);
  }


}