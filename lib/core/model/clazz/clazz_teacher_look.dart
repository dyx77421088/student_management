// To parse this JSON data, do
//
//     final dyxClazzSearchModel = dyxClazzSearchModelFromJson(jsonString);
/// 根据老师的token查看所带班级的返回的实体类
import 'dart:convert';

DYXClazzSearchModel dyxClazzSearchModelFromJson(String str) => DYXClazzSearchModel.fromJson(json.decode(str));

String dyxClazzSearchModelToJson(DYXClazzSearchModel data) => json.encode(data.toJson());

class DYXClazzSearchModel {
  DYXClazzSearchModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory DYXClazzSearchModel.fromJson(Map<String, dynamic> json) => DYXClazzSearchModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.className,
    this.headmaster,
    this.school,
    this.teachers,
  });

  int id;
  String className;
  int headmaster;
  int school;
  List<int> teachers;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    className: json["class_name"],
    headmaster: json["headmaster"],
    school: json["school"],
    teachers: List<int>.from(json["teachers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "class_name": className,
    "headmaster": headmaster,
    "school": school,
    "teachers": List<dynamic>.from(teachers.map((x) => x)),
  };
}
