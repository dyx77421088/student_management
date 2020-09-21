// To parse this JSON data, do
//
//     final dyxUserParentLoginModel = dyxUserParentLoginModelFromJson(jsonString);

import 'dart:convert';

import 'package:student_management/core/model/user/user_login_model.dart';
import 'package:student_management/core/model/user/user_login_role_info.dart';
import 'package:student_management/core/model/user/user_search_model.dart';

DYXUserParentLoginModel dyxUserParentLoginModelFromJson(String str) => DYXUserParentLoginModel.fromJson(json.decode(str));

String dyxUserParentLoginModelToJson(DYXUserParentLoginModel data) => json.encode(data.toJson());

class DYXUserParentLoginModel extends DYXUserLoginModel{
  DYXUserParentLoginModel({
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

  factory DYXUserParentLoginModel.fromJson(Map<String, dynamic> json) => DYXUserParentLoginModel(
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
    this.id,
    this.name,
  });

  int id;
  String name;

  factory RoleInfo.fromJson(Map<String, dynamic> json) => RoleInfo(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
