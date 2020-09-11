// To parse this JSON data, do
//
//     final dyxStudentModel = dyxStudentModelFromJson(jsonString);

import 'dart:convert';

import 'package:student_management/core/model/school/school_to_json_model.dart';
import 'package:student_management/core/model/user/user_to_json_model.dart';

DYXClassToJsonModel dyxClassToJsonModelFromJson(String str) => DYXClassToJsonModel.fromJson(json.decode(str));

String dyxClassToJsonModelToJson(DYXClassToJsonModel data) => json.encode(data.toJson());

class DYXClassToJsonModel {
  DYXClassToJsonModel({
    this.id,
    this.teacher,
    this.className,
    this.school,
  });

  int id;
  DYXUserToJsonModel teacher;
  String className;
  DYXSchoolToJsonModel school;

  factory DYXClassToJsonModel.fromJson(Map<String, dynamic> json) => DYXClassToJsonModel(
    id: json["id"],
    teacher: DYXUserToJsonModel.fromJson(json["teacher"]),
    className: json["class_name"],
    school: DYXSchoolToJsonModel.fromJson(json["school"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "teacher": teacher.toJson(),
    "class_name": className,
    "school": school.toJson(),
  };
}