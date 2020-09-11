import 'dart:convert';

DYXUserToJsonModel dyxUserToJsonModelFromJson(String str) => DYXUserToJsonModel.fromJson(json.decode(str));

String dyxUserToJsonModelToJson(DYXUserToJsonModel data) => json.encode(data.toJson());

class DYXUserToJsonModel {
  DYXUserToJsonModel({
    this.userName,
    this.phoneNumber,
    this.role,
  });

  String userName;
  String phoneNumber;
  int role;

  factory DYXUserToJsonModel.fromJson(Map<String, dynamic> json) => DYXUserToJsonModel(
    userName: json["user_name"],
    phoneNumber: json["phone_number"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "phone_number": phoneNumber,
    "role": role,
  };
}
