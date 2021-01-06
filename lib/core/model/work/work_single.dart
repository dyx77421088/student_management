// To parse this JSON data, do
//
//     final dyxWorkSingleModel = dyxWorkSingleModelFromJson(jsonString);

import 'dart:convert';

DYXWorkSingleModel dyxWorkSingleModelFromJson(String str) => DYXWorkSingleModel.fromJson(json.decode(str));

String dyxWorkSingleModelToJson(DYXWorkSingleModel data) => json.encode(data.toJson());

class DYXWorkSingleModel {
  DYXWorkSingleModel({
    this.id,
    this.userDetails,
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
  UserDetails userDetails;
  String course;
  String title;
  String content;
  int releaseTime;
  int startDate;
  int endDate;
  String file;
  String request;
  int teacher;
  int clazz;

  factory DYXWorkSingleModel.fromJson(Map<String, dynamic> json) => DYXWorkSingleModel(
    id: json["id"],
    userDetails: UserDetails.fromJson(json["user_details"]),
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
    "user_details": userDetails.toJson(),
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

class UserDetails {
  UserDetails({
    this.avatar,
    this.name,
  });

  dynamic avatar;
  String name;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    avatar: json["avatar"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "name": name,
  };
}
