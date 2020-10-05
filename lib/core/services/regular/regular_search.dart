import 'package:dio/dio.dart';
import 'package:student_management/core/model/regular/regular_search_model.dart';
import 'package:student_management/core/services/http_request.dart';

class DYXRegularSearch {
  static Future<DYXRegularSearchModel> search({
    String token,
    bool isSystem = true,
  }) async{
    FormData formData = FormData.fromMap({
      "isSystem": isSystem ? 1 : 0,
    });
    var data = await DYXHttpRequest().request(
      "/regular/search",
      headers: {"token": token},
      data: formData
    );
    print(data);
    return DYXRegularSearchModel.fromJson(data);
  }
}