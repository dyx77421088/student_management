import 'dart:convert';

DYXSchoolToJsonModel dyxSchoolToJsonModelFromJson(String str) => DYXSchoolToJsonModel.fromJson(json.decode(str));

String dyxSchoolToJsonModelToJson(DYXSchoolToJsonModel data) => json.encode(data.toJson());

class DYXSchoolToJsonModel {
  DYXSchoolToJsonModel({
    this.schoolName,
    this.schoolInfo,
    this.schoolDate,
  });

  String schoolName;
  String schoolInfo;
  String schoolDate;

  factory DYXSchoolToJsonModel.fromJson(Map<String, dynamic> json) => DYXSchoolToJsonModel(
    schoolName: json["school_name"],
    schoolInfo: json["school_info"],
    schoolDate: json["school_date"],
  );

  Map<String, dynamic> toJson() => {
    "school_name": schoolName,
    "school_info": schoolInfo,
    "school_date": schoolDate,
  };
}
