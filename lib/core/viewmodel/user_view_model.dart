import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_management/core/model/user/user_model.dart';
import 'package:student_management/core/services/user/user_request.dart';
/// 用户的一些信息的通知
class DYXUserViewModel extends ChangeNotifier {
  DYXUserModel _user;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;

  DYXUserViewModel() {
    init().then((value) {
      print("是否为空${prefs == null}");
      if(prefs.getBool("isLogin") == null) {
        logOut();
        notifyListeners();
        return;
      }
      print("进来了");
      print(prefs.getString("token") == null);
      // 尝试登录
      if (prefs.getString("token") != null) {
        // 发送请求
        DYXUserRequest.onToken(prefs.getString("token")).then((value) => _saveInfo(value));
      }
      notifyListeners();
    });
  }

  Future<bool> init() async{
    prefs = await _prefs;
    return true;
  }

  set user(DYXUserModel user) {
    _user = user;
    // 保存信息
    _saveInfo(user);
    notifyListeners();
  }

  /// 保存信息
  void _saveInfo(DYXUserModel user) async{
//    SharedPreferences prefs = await _prefs;
    var data = user.data;
    prefs.setString("name", data.name);
    prefs.setString("userName", data.userName);
    prefs.setString("school", data.school);
    prefs.setString("phoneNumber", data.phoneNumber);
    prefs.setString("token", data.token);
    prefs.setInt("role", data.role);
    prefs.setInt("id", data.id);
    prefs.setBool("isLogin", true);

    print("用户名:${user.data.userName}");
    print("用户名:${user.data.name}");
    print("用户名:${user.data.phoneNumber}");
    print("用户名:${user.data.school}");

    notifyListeners();
  }

  /// 注销
  void logOut() {
    prefs.remove("name");
    prefs.remove("userName");
    prefs.remove("school");
    prefs.remove("phoneNumber");
    prefs.remove("token");
    prefs.remove("role");
    prefs.remove("role");
    prefs.remove("id");
    prefs.setBool("isLogin", false);
  }

  // 获得信息
  /// 真实姓名
  String get name => isLogin ? prefs.getString("name") : null;
  /// 用户名
  String get userName => isLogin ? prefs.getString("userName") : null;
  /// 学校
  String get school => isLogin ? prefs.getString("school") : null;
  /// 手机号
  String get phoneNumber => isLogin ? prefs.getString("phoneNumber") : null;
  /// token
  String get token => isLogin ? prefs.getString("token") : null;
  /// 角色
  int get role => isLogin ? prefs.getInt("role") : null;
  /// 用户id
  int get id => isLogin ? prefs.getInt("id") : null;
  /// 是否登录
  bool get isLogin => prefs == null ? false : prefs.getBool("isLogin");
}