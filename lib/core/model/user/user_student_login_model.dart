// To parse this JSON data, do
//
//     final dyxStudentModel = dyxStudentModelFromJson(jsonString);

import 'dart:convert';

import 'package:student_management/core/model/clazz/class_to_json_model.dart';
import 'package:student_management/core/model/parent/parent_to_json_model.dart';
import 'package:student_management/core/model/school/school_to_json_model.dart';
import 'package:student_management/core/model/user/user_login_model.dart';
import 'package:student_management/core/model/user/user_login_role_info.dart';
import 'package:student_management/core/model/user/user_search_model.dart';

DYXUserStudentLoginModel dyxUserStudentLoginModelFromJson(String str) => DYXUserStudentLoginModel.fromJson(json.decode(str));

String dyxUserStudentLoginModelToJson(DYXUserStudentLoginModel data) => json.encode(data.toJson());

class DYXUserStudentLoginModel extends DYXUserLoginModel{
  DYXUserStudentLoginModel({
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

  factory DYXUserStudentLoginModel.fromJson(Map<String, dynamic> json) => DYXUserStudentLoginModel(
    message: json["message"],
    data: DYXUserSearchModel.fromJson(json["data"]),
    roleInfo: RoleInfo.fromJson(json["role_info"]),
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
    this.clazz,
    this.school,
    this.parent,
  });

  DYXClassToJsonModel clazz;
  DYXSchoolToJsonModel school;
  List<DYXParentToJsonModel> parent;

  factory RoleInfo.fromJson(Map<String, dynamic> json) => RoleInfo(
    clazz: DYXClassToJsonModel.fromJson(json["clazz"]),
    school: DYXSchoolToJsonModel.fromJson(json["school"]),
    parent: List<DYXParentToJsonModel>.from(json["parent"].map((x) => DYXParentToJsonModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "clazz": clazz.toJson(),
    "school": school.toJson(),
    "parent": List<dynamic>.from(parent.map((x) => x.toJson())),
  };
}