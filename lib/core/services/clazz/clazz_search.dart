import 'package:student_management/core/model/clazz/clazz_teacher_look.dart';
import 'package:student_management/core/services/http_request.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/shared/toast/toast.dart';

class DYXClazzSearch {
  /// 根据老师token查看所任课的班级
  static Future<DYXClazzSearchModel> searchByTeacherToken({
    int index = 1,
  }) async{
    var data = await DYXHttpRequest().request(
      "/teacher/getClazzByTeacher",
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
      DYXToast.showToast("暂无!");
      return null;
    }
    return DYXClazzSearchModel.fromJson(data);
  }
}