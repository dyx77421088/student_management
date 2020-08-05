// To parse this JSON data, do
//
//     final dyxUserDetailsModel = dyxUserDetailsModelFromJson(jsonString);

import 'dart:convert';

DYXUserDetailsModel dyxUserDetailsModelFromJson(String str) => DYXUserDetailsModel.fromJson(json.decode(str));

String dyxUserDetailsModelToJson(DYXUserDetailsModel data) => json.encode(data.toJson());

String _getSex(int value) {
  if(value == -1)
    return "女";
  else if(value == 1)
    return "男";
  return "保密";
}

class DYXUserDetailsModel {
  DYXUserDetailsModel({
    this.data,
    this.code,
    this.status,
  });

  Data data;
  int code;
  int status;

  factory DYXUserDetailsModel.fromJson(Map<String, dynamic> json) => DYXUserDetailsModel(
    data: Data.fromJson(json["data"]),
    code: json["code"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "code": code,
    "status": status,
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.avatar,
    this.sex,
    this.strSex,
    this.birthday,
    this.personalSignature,
    this.user,
  });

  int id;
  String name;
  String avatar;
  int sex;
  String strSex;
  String birthday;
  String personalSignature;
  int user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
    sex: json["sex"],
    strSex: _getSex(json['sex']),
    birthday: json["birthday"],
    personalSignature: json["personal_signature"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "sex": sex,
    "strSex": strSex,
    "birthday": birthday,
    "personal_signature": personalSignature,
    "user": user,
  };
}
