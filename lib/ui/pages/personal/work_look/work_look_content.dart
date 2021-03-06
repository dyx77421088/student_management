import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/model/work/work_search.dart';
import 'package:student_management/core/model/work/work_single.dart';
import 'package:student_management/core/services/work/work_search.dart';
import 'package:student_management/core/utils/date_time_utils.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/shared/blank_page/blank_page.dart';
import 'package:student_management/ui/shared/refresh/easy_refresh/my_easy_refresh_model.dart';
import 'package:student_management/ui/shared/sliver_sticky_header/sliver_sticky_header.dart';
import 'package:student_management/ui/shared/toast/toast.dart';
import 'package:student_management/ui/widgets/work_item.dart';

class DYXWorkLookContent extends StatefulWidget {
  @override
  _DYXWorkContentState createState() => _DYXWorkContentState();
}

class _DYXWorkContentState extends State<DYXWorkLookContent> {
  DYXWorkSearchModel data;
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return buildData();
  }

  Widget buildData() => Consumer<DYXUserViewModel>(
    builder: (ctx, userVM, child) => DYXEasyRefreshModel(
      slivers: data == null ? [SliverList(delegate: SliverChildListDelegate(
          [DYXBlankPage()]
      ))] : buildDataChildren(userVM),
      onRefresh: () async{
        index = 1;
        data = await DYXWorkSearch.search(index:index);
        print(data);
        setState(() {});
      },
      onLoad: data == null ? null : ()async{
        var t = await DYXWorkSearch.search(index: ++index);
        if (t == null) {
          DYXToast.showToast("没有更多的了");
          return;
        } else {
          data.results.addAll(t.results);
          setState(() {});
        }
      },
    ),
  );

  /// 处理数据
  List<Widget> buildDataChildren(DYXUserViewModel userVM) {
    List<Widget> stickyHeaderList = [];
    // 可以查看的

    List<DYXWorkSingleModel> d = filterGoOn();
    add("语文", stickyHeaderList, d, isOpen: true);
    add("英语", stickyHeaderList, d);
    add("数学", stickyHeaderList, d);
    add("体育", stickyHeaderList, d);
    add("其它", stickyHeaderList, d);

    List<DYXWorkSingleModel> noStart = filterNoStart();
    add("未开始", stickyHeaderList, noStart);
    List<DYXWorkSingleModel> end = filterEnd();
    add("已结束", stickyHeaderList, end);
    return stickyHeaderList;
  }

  void add(String course, List<Widget> stickyHeaderList, List<DYXWorkSingleModel> data, {bool isOpen=false}) {
    var t = filterType(course, data);
    if (course == "已结束" || course == "未开始") t = data;
    else if (t.length <= 0) return;
    stickyHeaderList.add(DYXSliverStickyHeader(
      isOpen: isOpen,
      slivers: SliverGrid.count(
        crossAxisCount: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3,
        children: t.map((e) => Container(
          child: DYXWorkItem(regularItem: e, canUpdate: true, hui: (str) async{
            // index = 1;
            // this.data = await DYXWorkSearch.search(index:index);
            this.data.results.remove(data.firstWhere((element) => element.id == str));
            setState(() {});
          },))
        ).toList(),
      ), title: "$course(${t.length})",
    ));
  }

  /// 进行中的
  List<DYXWorkSingleModel> filterGoOn() => data.results.where((element) =>
    DYXDateTimeUtils.getNowTimeStamp() > element.startDate
    && DYXDateTimeUtils.getNowTimeStamp() < element.endDate // 在这个时间段内
  ).toList();

  /// 已结束的
  List<DYXWorkSingleModel> filterEnd() => data.results.where((element) =>
    DYXDateTimeUtils.getNowTimeStamp() > element.endDate
  ).toList();

  /// 未开始的
  List<DYXWorkSingleModel> filterNoStart() => data.results.where((element) =>
    DYXDateTimeUtils.getNowTimeStamp() < element.startDate
  ).toList();

  /// 根据类型删选
  List<DYXWorkSingleModel> filterType(String course, List<DYXWorkSingleModel> data) {
    if (course == "其它")
      return data.where((element) => element.course != "语文" && element.course != "数学"
          && element.course != "英语" && element.course != "体育"
      ).toList();
    return data.where((element) => element.course == course).toList();
  }
}
