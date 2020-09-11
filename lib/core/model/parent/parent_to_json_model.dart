import 'dart:convert';

DYXParentToJsonModel dyxParentToJsonModelFromJson(String str) => DYXParentToJsonModel.fromJson(json.decode(str));

String dyxParentToJsonModelToJson(DYXParentToJsonModel data) => json.encode(data.toJson());

class DYXParentToJsonModel {
  DYXParentToJsonModel({
    this.id,
    this.name
  });

  int id;
  String name;

  factory DYXParentToJsonModel.fromJson(Map<String, dynamic> json) => DYXParentToJsonModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
