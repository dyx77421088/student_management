// To parse this JSON data, do
//
//     final dyxUserDetailsAllModel = dyxUserDetailsAllModelFromJson(jsonString);

import 'dart:convert';
import 'package:date_format/date_format.dart';

import 'package:student_management/core/utils/date_time_utils.dart';

DYXUserDetailsAllModel dyxUserDetailsAllModelFromJson(String str) => DYXUserDetailsAllModel.fromJson(json.decode(str));

String dyxUserDetailsAllModelToJson(DYXUserDetailsAllModel data) => json.encode(data.toJson());

class DYXUserDetailsAllModel {
  DYXUserDetailsAllModel({
    this.id,
    this.name,
    this.avatar,
    this.card,
    this.sex,
    this.sexStr,
    this.birthday,
    this.birthdayStr,
    this.qq,
    this.email,
    this.personalSignature,
  });

  int id;
  String name;
  String avatar;
  String card;
  int sex;
  String sexStr;
  int birthday;
  String birthdayStr;
  String qq;
  String email;
  String personalSignature;

  factory DYXUserDetailsAllModel.fromJson(Map<String, dynamic> json) => DYXUserDetailsAllModel(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
    card: json["card"],
    sex: json["sex"],
    sexStr: json["sex"] == -1 ? "女" : (json['sex'] == 1 ? "男" : "保密"),
    birthday: json["birthday"],
    birthdayStr: DYXDateTimeUtils.timeStampFormatToStr(json["birthday"], [yyyy, '-', mm, '-', dd]),
    qq: json["qq"],
    email: json["email"],
    personalSignature: json["personal_signature"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "card": card,
    "sex": sex,
    "birthday": birthday,
    "qq": qq,
    "email": email,
    "personal_signature": personalSignature,
  };
}
