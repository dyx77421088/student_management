import 'dart:convert';

import 'package:student_management/core/model/user_details/user_details_all_model.dart';

DYXUserSearchModel dyxUserSearchModelFromJson(String str) => DYXUserSearchModel.fromJson(json.decode(str));

String dyxUserSearchModelToJson(DYXUserSearchModel data) => json.encode(data.toJson());

class DYXUserSearchModel {
  DYXUserSearchModel({
    this.id,
    this.userName,
    this.phoneNumber,
    this.role,
    this.token,
    this.userDetails,
  });

  int id;
  String userName;
  String phoneNumber;
  int role;
  String token;
  DYXUserDetailsAllModel userDetails;

  factory DYXUserSearchModel.fromJson(Map<String, dynamic> json) => DYXUserSearchModel(
    id: json["id"],
    userName: json["user_name"],
    phoneNumber: json["phone_number"],
    role: json["role"],
    token: json["token"],
    userDetails: json["user_details"] != null ? DYXUserDetailsAllModel.fromJson(json["user_details"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_name": userName,
    "phone_number": phoneNumber,
    "role": role,
    "token": token,
    "user_details": userDetails.toJson(),
  };
}