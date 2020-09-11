import 'dart:convert';

DYXParentSearchModel dyxParentSearchModelFromJson(String str) => DYXParentSearchModel.fromJson(json.decode(str));

String dyxParentSearchModelToJson(DYXParentSearchModel data) => json.encode(data.toJson());

class DYXParentSearchModel {
  DYXParentSearchModel({
    this.id,
    this.name,
    this.sex,
    this.card,
    this.phoneNumber,
    this.birthday,
    this.qq,
    this.email,
  });

  int id;
  String name;
  int sex;
  String card;
  String phoneNumber;
  String birthday;
  dynamic qq;
  dynamic email;

  factory DYXParentSearchModel.fromJson(Map<String, dynamic> json) => DYXParentSearchModel(
    id: json["id"],
    name: json["name"],
    sex: json["sex"],
    card: json["card"],
    phoneNumber: json["phone_number"],
    birthday: json["birthday"],
    qq: json["qq"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "sex": sex,
    "card": card,
    "phone_number": phoneNumber,
    "birthday": birthday,
    "qq": qq,
    "email": email,
  };
}
