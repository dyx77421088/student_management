
import 'package:flutter/cupertino.dart';
import 'package:student_management/core/model/regular_add_record/regular_add_record_model.dart';
import 'package:student_management/core/services/http_request.dart';
import 'package:student_management/core/view_model/user_view_model.dart';

/// 添加打卡
class DYXRegularAddRecordServices {
  /// 插入一条打卡数据
  static Future insert({
    @required String token,
    String describe, // 描述
    int regular, // 对应添加的打卡
    int reminderTime,  // 提醒时间
    int startTime, // 开始时间
    int endTime, // 结束时间
    int startDate, // 开始日期
    int endDate, // 结束日期
    List<int> week
  }) {
    return DYXHttpRequest().request(
      "/regularAddRecord/insert",
      method: "post",
      data: {
        "describe": describe,
        "regular": regular,
        "reminder_time": reminderTime,
        "start_time": startTime,
        "end_time": endTime,
        "start_date": startDate,
        "end_date": endDate,
        "week": week,
      },
      headers: {"token": token},
    );
  }

  static Future<DYXRegularAddRecordSearchModel> search({
    int userId,
    int regular
  }) async{
    // 传数据
    var data = {};
    if (userId != null) {
      data['user'] = userId;
    }
    if (regular != null) {
      data['regular'] = regular;
    }
    var d = await DYXHttpRequest().request(
        "/regularAddRecord/search",
        headers: {"token": DYXUserViewModel.staticToken},
        data: data
    );
    return DYXRegularAddRecordSearchModel.fromJson(d);
  }
}