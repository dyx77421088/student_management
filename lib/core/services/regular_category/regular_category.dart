import 'package:flutter/material.dart';
import 'package:student_management/core/model/regularCategory/regular_category_model.dart';
import 'package:student_management/core/services/http_request.dart';

class DYXRegularCategory {
  static Future<DYXRegularCategorySearchModel> search({
    @required String token,
  }) async{
    var data = await DYXHttpRequest().request(
      "/regularCategory/search",
      headers: {"token": token}
    );
    return DYXRegularCategorySearchModel.fromJson(data);
  }
}