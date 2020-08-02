// To parse this JSON data, do
//
//     final dyxUserModel = dyxUserModelFromJson(jsonString);

import 'dart:convert';

DYXUserModel dyxUserModelFromJson(String str) => DYXUserModel.fromJson(json.decode(str));

String dyxUserModelToJson(DYXUserModel data) => json.encode(data.toJson());

class DYXUserModel {
  DYXUserModel({
    this.message,
    this.data,
    this.code,
    this.status,
  });

  String message;
  Data data;
  int code;
  int status;

  factory DYXUserModel.fromJson(Map<String, dynamic> json) => DYXUserModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
    code: json["code"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
    "code": code,
    "status": status,
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.userName,
    this.phoneNumber,
    this.role,
    this.token,
    this.school,
  });

  int id;
  String name;
  String userName;
  String phoneNumber;
  int role;
  String token;
  String school;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    userName: json["user_name"],
    phoneNumber: json["phone_number"],
    role: json["role"],
    token: json["token"],
    school: json["school"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "user_name": userName,
    "phone_number": phoneNumber,
    "role": role,
    "token": token,
    "school": school,
  };
}
