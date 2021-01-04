
import 'package:student_management/core/model/work/work_search.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/shared/toast/toast.dart';

import '../http_request.dart';

class DYXWorkSearch {
  /// 查看作业
  static Future<DYXWorkSearchModel> search() async{
    var data = await DYXHttpRequest().request(
      "/work/getClassInfo",
      headers: {"token": DYXUserViewModel.staticToken},
      method: "get",
      showSuccessMessage: false,
    );
    print(data);
    if (data['code'] == 110) {
      DYXToast.showToast("未找到所带班级信息");
      return null;
    }
    return DYXWorkSearchModel.fromJson(data);
  }
}