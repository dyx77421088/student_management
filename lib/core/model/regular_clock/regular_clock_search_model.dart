import 'dart:convert';

DYXRegularClockSearchModel dyxRegularClockSearchModelFromJson(String str) => DYXRegularClockSearchModel.fromJson(json.decode(str));

String dyxRegularClockSearchModelToJson(DYXRegularClockSearchModel data) => json.encode(data.toJson());

class DYXRegularClockSearchModel {
  DYXRegularClockSearchModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory DYXRegularClockSearchModel.fromJson(Map<String, dynamic> json) => DYXRegularClockSearchModel(
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
    this.clockInTimeStr,
    this.image,
    this.mood,
    this.clockInTime,
    this.regularAddRecord,
  });

  int id;
  DateTime clockInTimeStr;
  String image;
  String mood;
  int clockInTime;
  int regularAddRecord;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    clockInTimeStr: DateTime.parse(json["clock_in_time_str"]),
    image: json["image"] == null ? null : json["image"],
    mood: json["mood"],
    clockInTime: json["clock_in_time"],
    regularAddRecord: json["regular_add_record"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "clock_in_time_str": clockInTimeStr.toIso8601String(),
    "image": image == null ? null : image,
    "mood": mood,
    "clock_in_time": clockInTime,
    "regular_add_record": regularAddRecord,
  };
}
