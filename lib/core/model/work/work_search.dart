// To parse this JSON data, do
//
//     final dyxWorkSearchModel = dyxWorkSearchModelFromJson(jsonString);

import 'dart:convert';

DYXWorkSearchModel dyxWorkSearchModelFromJson(String str) => DYXWorkSearchModel.fromJson(json.decode(str));

String dyxWorkSearchModelToJson(DYXWorkSearchModel data) => json.encode(data.toJson());

class DYXWorkSearchModel {
  DYXWorkSearchModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory DYXWorkSearchModel.fromJson(Map<String, dynamic> json) => DYXWorkSearchModel(
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
    this.course,
    this.title,
    this.content,
    this.releaseTime,
    this.startDate,
    this.endDate,
    this.file,
    this.request,
    this.teacher,
    this.clazz,
  });

  int id;
  String course;
  String title;
  String content;
  int releaseTime;
  int startDate;
  int endDate;
  dynamic file;
  dynamic request;
  int teacher;
  int clazz;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    course: json["course"],
    title: json["title"],
    content: json["content"],
    releaseTime: json["release_Time"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    file: json["file"],
    request: json["request"],
    teacher: json["teacher"],
    clazz: json["clazz"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "course": course,
    "title": title,
    "content": content,
    "release_Time": releaseTime,
    "start_date": startDate,
    "end_date": endDate,
    "file": file,
    "request": request,
    "teacher": teacher,
    "clazz": clazz,
  };
}
