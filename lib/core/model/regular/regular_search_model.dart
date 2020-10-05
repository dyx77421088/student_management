import 'dart:convert';

DYXRegularSearchModel dyxRegularSearchFromJson(String str) => DYXRegularSearchModel.fromJson(json.decode(str));

String dyxRegularSearchToJson(DYXRegularSearchModel data) => json.encode(data.toJson());

class DYXRegularSearchModel {
  DYXRegularSearchModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory DYXRegularSearchModel.fromJson(Map<String, dynamic> json) => DYXRegularSearchModel(
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
