
import 'package:student_management/core/model/work/work_search.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/shared/toast/toast.dart';

import '../http_request.dart';

class DYXWorkSearch {
  /// 查看作业(辅导员查看班级的)
  static Future<DYXWorkSearchModel> search({
    int index = 1,
  }) async{
    var data = await DYXHttpRequest().request(
      "/work/getClassInfo",
      headers: {"token": DYXUserViewModel.staticToken},
      method: "get",
      params: {
        "index":index
      },
      showSuccessMessage: false,
    ).catchError((e) {
      print("错误了");
    });
    if (data == null) return null;
    if (data['code'] == 110) {
      DYXToast.showToast("未找到所带班级信息");
      return null;
    }

    return DYXWorkSearchModel.fromJson(data);
  }

  /// 查看作业(辅导员查看班级的)
  static Future<DYXWorkSearchModel> searchByStudent({
    int index = 1,
  }) async{
    var data = await DYXHttpRequest().request(
      "/work/getStudentInfo",
      headers: {"token": DYXUserViewModel.staticToken},
      method: "get",
      params: {
        "index":index
      },
      showSuccessMessage: false,
    ).catchError((e) {
      print("错误了");
    });
    if (data == null) return null;
    if (data['code'] == 110) {
      DYXToast.showToast("暂无作业");
      return null;
    }

    return DYXWorkSearchModel.fromJson(data);
  }
}