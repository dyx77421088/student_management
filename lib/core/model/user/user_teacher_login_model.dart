import 'dart:convert';

import 'package:student_management/core/model/school/school_to_json_model.dart';
import 'package:student_management/core/model/user/user_login_model.dart';
import 'package:student_management/core/model/user/user_login_role_info.dart';
import 'package:student_management/core/model/user/user_search_model.dart';

DYXUserTeacherLoginModel dyxUserTeacherLoginModelFromJson(String str) => DYXUserTeacherLoginModel.fromJson(json.decode(str));

String dyxUserTeacherLoginModelToJson(DYXUserTeacherLoginModel data) => json.encode(data.toJson());

class DYXUserTeacherLoginModel extends DYXUserLoginModel{
  DYXUserTeacherLoginModel({
    this.message,
    this.data,
    this.roleInfo,
    this.code,
    this.status,
  });

  String message;
  DYXUserSearchModel data;
  RoleInfo roleInfo;
  int code;
  int status;

  factory DYXUserTeacherLoginModel.fromJson(Map<String, dynamic> json) => DYXUserTeacherLoginModel(
    message: json["message"],
    data: json["data"] != null ? DYXUserSearchModel.fromJson(json["data"]) : null,
    roleInfo: json["role_info"] != null ? RoleInfo.fromJson(json["role_info"]) : null,
    code: json["code"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
    "role_info": roleInfo.toJson(),
    "code": code,
    "status": status,
  };
}
class RoleInfo extends DYXUserLoginRoleInfo{
  RoleInfo({
    this.title,
    this.identity,
    this.school,
  });

  String title;
  String identity;
  DYXSchoolToJsonModel school;

  factory RoleInfo.fromJson(Map<String, dynamic> json) => RoleInfo(
    title: json["title"],
    identity: json["identity"],
    school: json["school"] != null ? DYXSchoolToJsonModel.fromJson(json["school"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "identity": identity,
    "school": school.toJson(),
  };
}
