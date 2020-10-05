import 'dart:convert';

DYXTimetableModel dyxTimetableModelFromJson(String str) => DYXTimetableModel.fromJson(json.decode(str));

String dyxTimetableModelToJson(DYXTimetableModel data) => json.encode(data.toJson());

class DYXTimetableModel {
  DYXTimetableModel({
    this.data,
    this.code,
  });

  List<Datum> data;
  int code;

  factory DYXTimetableModel.fromJson(Map<String, dynamic> json) => DYXTimetableModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "code": code,
  };
}

class Datum {
  Datum({
    this.id,
    this.date,
    this.clazz,
    this.week,
    this.course,
  });

  int id;
  DateTime date;
  Clazz clazz;
  Week week;
  List<Course> course;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    clazz: Clazz.fromJson(json["clazz"]),
    week: Week.fromJson(json["week"]),
    course: List<Course>.from(json["course"].map((x) => Course.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "clazz": clazz.toJson(),
    "week": week.toJson(),
    "course": List<dynamic>.from(course.map((x) => x.toJson())),
  };
}

class Clazz {
  Clazz({
    this.id,
    this.clazzName,
  });

  int id;
  String clazzName;

  factory Clazz.fromJson(Map<String, dynamic> json) => Clazz(
    id: json["id"],
    clazzName: json["clazz_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "clazz_name": clazzName,
  };
}

class Course {
  Course({
    this.id,
    this.courseName,
    this.index,
    this.teacher,
  });

  int id;
  String courseName;
  int index;
  Teacher teacher;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json["id"],
    courseName: json["course_name"],
    index: json["index"],
    teacher: Teacher.fromJson(json["teacher"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "course_name": courseName,
    "index": index,
    "teacher": teacher.toJson(),
  };
}

class Teacher {
  Teacher({
    this.name,
    this.phoneNumber,
  });

  String name;
  String phoneNumber;

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
    name: json["name"],
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone_number": phoneNumber,
  };
}

class Week {
  Week({
    this.id,
    this.index,
    this.title,
  });

  int id;
  int index;
  dynamic title;

  factory Week.fromJson(Map<String, dynamic> json) => Week(
    id: json["id"],
    index: json["index"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "index": index,
    "title": title,
  };
}
