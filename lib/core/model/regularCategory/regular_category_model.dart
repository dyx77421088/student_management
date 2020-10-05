
import 'dart:convert';

DYXRegularCategorySearchModel dyxRegularCategorySearchModelFromJson(String str) => DYXRegularCategorySearchModel.fromJson(json.decode(str));

String dyxRegularCategorySearchModelToJson(DYXRegularCategorySearchModel data) => json.encode(data.toJson());

class DYXRegularCategorySearchModel {
  DYXRegularCategorySearchModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory DYXRegularCategorySearchModel.fromJson(Map<String, dynamic> json) => DYXRegularCategorySearchModel(
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
    this.title,
  });

  int id;
  String title;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
