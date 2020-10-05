import 'package:flutter/cupertino.dart';
import 'package:student_management/core/model/timetable/timetable_model.dart';
import 'package:student_management/core/services/http_request.dart';

class DYXTimetableSelect {
  static Future<DYXTimetableModel> selectTimetableByToken({@required String token}) async{
    var request = await DYXHttpRequest().request(
      "/timetable/selectStudentTimetableByToken",
      headers: {"token": token},
      method: "post"
    );
    return DYXTimetableModel.fromJson(request);
  }
}