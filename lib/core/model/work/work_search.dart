// To parse this JSON data, do
//
//     final dyxWorkSearchModel = dyxWorkSearchModelFromJson(jsonString);

import 'dart:convert';

import 'package:student_management/core/model/work/work_single.dart';

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
  List<DYXWorkSingleModel> results;

  factory DYXWorkSearchModel.fromJson(Map<String, dynamic> json) => DYXWorkSearchModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<DYXWorkSingleModel>.from(json["results"].map((x) => DYXWorkSingleModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}