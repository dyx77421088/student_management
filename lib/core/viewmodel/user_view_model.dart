import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_management/core/model/user/user_login_model.dart';
import 'package:student_management/core/model/user/user_login_role_info.dart';
import 'package:student_management/core/model/user/user_search_model.dart';
import 'package:student_management/core/model/user/user_student_login_model.dart' as Student;
import 'package:student_management/core/model/user/user_teacher_login_model.dart' as Teacher;
import 'package:student_management/core/model/user/user_parent_login_model.dart' as Parent;
import 'package:student_management/core/services/login/user_request.dart';
/// 用户的一些信息的通知
class DYXUserViewModel extends ChangeNotifier {
  DYXUserLoginModel _user;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;

  DYXUserViewModel() {
    init().then((value) {
      print("是否为空${prefs == null}");
      if(prefs.getBool("isLogin") == null) {
        logOut();
        return;
      }
      print("进来了");
      print(prefs.getString("token") == null);
      // 尝试登录
      if (prefs.getString("token") != null) {
        // 发送请求
        DYXUserRequest.onToken(prefs.getString("token"), inter: InterceptorsWrapper(
          onError: (err) {
//            遇到错误，登出
            logOut();
          }
        )).then((value) => _saveInfo(value));
      }
    });
  }

  Future<bool> init() async{
    prefs = await _prefs;
    return true;
  }

  set user(DYXUserLoginModel user) {
    _user = user;
    // 保存信息
    _saveInfo(user);
    notifyListeners();
  }

  /// 保存信息
  void _saveInfo(DYXUserLoginModel user) async{
    SharedPreferences prefs = await _prefs;
    if (user is Student.DYXUserStudentLoginModel) { // 登录的是学生用户
      _saveData(prefs, user.data);
      _saveRoleInfo(prefs, user.roleInfo);
    } else if (user is Teacher.DYXUserTeacherLoginModel) { // 登录的是老师用户
      _saveData(prefs, user.data);
      _saveRoleInfo(prefs, user.roleInfo);
    } else if (user is Parent.DYXUserParentLoginModel) { // 登录的是家长用户
      _saveData(prefs, user.data);
      _saveRoleInfo(prefs, user.roleInfo);
    }

    prefs.setBool("isLogin", true);
    notifyListeners();
  }

  /// 保存用户信息
  void _saveData(SharedPreferences prefs, DYXUserSearchModel user) {
    prefs.setInt("id", user.id);
    prefs.setInt("role", user.role);
    prefs.setString("userName", user.userName);
    prefs.setString("phoneNumber", user.phoneNumber);
    prefs.setString("token", user.token);

    var userDetails = user.userDetails;
    prefs.setInt("userDetailsId", userDetails.id);
    prefs.setString("name", userDetails.name);
    prefs.setString("avatar", userDetails.avatar);
    prefs.setString("birthday", userDetails.birthdayStr);
    prefs.setString("qq", userDetails.qq);
    prefs.setString("email", userDetails.email);
    prefs.setString("card", userDetails.card);
    prefs.setString("sex", userDetails.sexStr);
  }

  /// 保存角色的信息
  void _saveRoleInfo(SharedPreferences prefs, DYXUserLoginRoleInfo roleInfo) {
    if (roleInfo is Student.RoleInfo) { // 学生角色的信息
      var school = roleInfo.school;
      if (school != null) { // 保存学校信息
        prefs.setString("schoolName", school.schoolName);
        prefs.setString("schoolInfo", school.schoolInfo);
        prefs.setString("schoolDate", school.schoolDate);
      }
      var clazz = roleInfo.clazz;
      if (clazz != null) { // 保存班级信息
        prefs.setString("className", clazz.className);
        var teacher = clazz.teacher;
        if (teacher != null) { // 保存班主任信息
          prefs.setString("teacherName", teacher.userName);
          prefs.setString("teacherPhoneNumber", teacher.phoneNumber);
        }
      }
    } else if(roleInfo is Teacher.RoleInfo) { // 老师角色的信息
      prefs.setString("title", roleInfo.title);
      prefs.setString("identity", roleInfo.identity);
      var school = roleInfo.school;
      if (school != null) { // 保存学校信息
        prefs.setString("schoolName", school.schoolName);
        prefs.setString("schoolInfo", school.schoolInfo);
        prefs.setString("schoolDate", school.schoolDate);
      }
    } else if (roleInfo is Parent.RoleInfo) { // 家长角色的信息

    }
  }
  /// 注销
  void logOut() {
    prefs.clear();
    prefs.setBool("isLogin", false);
    notifyListeners();
  }

  // 获得信息
  /// 真实姓名
  String get name => isLogin ? prefs.getString("name") : null;
  /// 用户名
  String get userName => isLogin ? prefs.getString("userName") : null;
  /// 学校
  String get schoolName => isLogin ? prefs.getString("schoolName") : null;
  /// 班级
  String get className => isLogin ? prefs.getString("className") : null;
  /// 手机号
  String get phoneNumber => isLogin ? prefs.getString("phoneNumber") : null;
  /// token
  String get token => isLogin ? prefs.getString("token") : null;
  /// 角色
  int get role => isLogin ? prefs.getInt("role") : null;
  /// 用户id
  int get id => isLogin ? prefs.getInt("id") : null;

  // 用户详细信息
  /// 头像
  String get avatar => isLogin ? prefs.getString("avatar") : null;
  /// 性别
  String get sex => isLogin ? prefs.getString("sex") : null;
  /// 生日
  String get birthday => isLogin ? prefs.getString("birthday") : null;
  /// 个性签名
  String get personalSignature => isLogin ? prefs.getString("personalSignature") : null;

  /// 是否登录
  bool get isLogin => prefs == null ? false : prefs.getBool("isLogin");
}