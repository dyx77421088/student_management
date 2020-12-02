import 'dart:convert';

DYXRegularAddRecordSearchModel dyxRegularAddRecordSearchModelFromJson(String str) => DYXRegularAddRecordSearchModel.fromJson(json.decode(str));

String dyxRegularAddRecordSearchModelToJson(DYXRegularAddRecordSearchModel data) => json.encode(data.toJson());

class DYXRegularAddRecordSearchModel {
  DYXRegularAddRecordSearchModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory DYXRegularAddRecordSearchModel.fromJson(Map<String, dynamic> json) => DYXRegularAddRecordSearchModel(
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
    this.regular,
    this.userId,
    this.reminderTimeStr,
    this.startTimeStr,
    this.endTimeStr,
    this.startDateStr,
    this.endDateStr,
    this.describe,
    this.reminderTime,
    this.startTime,
    this.endTime,
    this.startDate,
    this.endDate,
    this.week,
  });

  int id;
  Regular regular;
  int userId;
  String reminderTimeStr;
  String startTimeStr;
  String endTimeStr;
  String startDateStr;
  String endDateStr;
  String describe;
  int reminderTime;
  int startTime;
  int endTime;
  int startDate;
  int endDate;
  List<int> week;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    regular: Regular.fromJson(json["regular"]),
    userId: json["user_id"],
    reminderTimeStr: json["reminder_time_str"],
    startTimeStr: json["start_time_str"],
    endTimeStr: json["end_time_str"],
    startDateStr: json["start_date_str"],
    endDateStr: json["end_date_str"],
    describe: json["describe"],
    reminderTime: json["reminder_time"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    week: List<int>.from(json["week"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "regular": regular.toJson(),
    "user_id": userId,
    "reminder_time_str": reminderTimeStr,
    "start_time_str": startTimeStr,
    "end_time_str": endTimeStr,
    "start_date_str": startDateStr,
    "end_date_str": endDateStr,
    "describe": describe,
    "reminder_time": reminderTime,
    "start_time": startTime,
    "end_time": endTime,
    "start_date": startDate,
    "end_date": endDate,
    "week": List<dynamic>.from(week.map((x) => x)),
  };
}

class Regular {
  Regular({
    this.id,
    this.userId,
    this.creationTimeStr,
    this.image,
    this.title,
    this.describe,
    this.isSystem,
    this.creationTime,
    this.regularCategory,
    this.clazz,
  });

  int id;
  int userId;
  DateTime creationTimeStr;
  String image;
  String title;
  String describe;
  int isSystem;
  int creationTime;
  RegularCategory regularCategory;
  dynamic clazz;

  factory Regular.fromJson(Map<String, dynamic> json) => Regular(
    id: json["id"],
    userId: json["user_id"],
    creationTimeStr: DateTime.parse(json["creation_time_str"]),
    image: json["image"],
    title: json["title"],
    describe: json["describe"],
    isSystem: json["is_system"],
    creationTime: json["creation_time"],
    regularCategory: RegularCategory.fromJson(json["regular_category"]),
    clazz: json["clazz"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "creation_time_str": creationTimeStr.toIso8601String(),
    "image": image,
    "title": title,
    "describe": describe,
    "is_system": isSystem,
    "creation_time": creationTime,
    "regular_category": regularCategory.toJson(),
    "clazz": clazz,
  };
}

class RegularCategory {
  RegularCategory({
    this.id,
    this.title,
  });

  int id;
  String title;

  factory RegularCategory.fromJson(Map<String, dynamic> json) => RegularCategory(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
