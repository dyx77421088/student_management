import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/model/regular_add_record/regular_add_record_model.dart';
import 'package:student_management/core/services/regular_add_record/regular_add_record.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/core/utils/date_time_utils.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/pages/personal/regular/regular_content_edit/regulaar_content_edit.dart';
import 'package:student_management/ui/shared/refresh/easy_refresh/my_easy_refresh_model.dart';
import 'package:student_management/ui/shared/sliver_sticky_header/sliver_sticky_header.dart';
import 'package:student_management/ui/shared/toast/toast.dart';

/// 展示打卡的信息
class DYXRegularContent extends StatefulWidget {
  final DateTime now;

  DYXRegularContent(this.now);

  @override
  _DYXRegularContentState createState() => _DYXRegularContentState();
}

class _DYXRegularContentState extends State<DYXRegularContent> {
  DYXRegularAddRecordSearchModel data;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return buildData();
  }

  Widget buildData() => Consumer<DYXUserViewModel>(
    builder: (ctx, userVM, child) => DYXEasyRefreshModel(
      slivers: data == null ? [] : buildDataChildren(userVM),
      onRefresh: () async{
        data = await DYXRegularAddRecordServices.search();
        setState(() {});
      },
      onLoad: ()async{},
    ),
  );

  /// 处理数据
  List<Widget> buildDataChildren(DYXUserViewModel userVM) {
    List<Widget> stickyHeaderList = [];
    // 只查看选择的日期可以签到的
    var data = this.data.results.where((e) =>
      DYXDateTimeUtils.getNowTimeStamp(now: widget.now) >= DYXDateTimeUtils.floorTime(timeStamp: e.startDate)
      && DYXDateTimeUtils.getNowTimeStamp(now: widget.now) <= DYXDateTimeUtils.ceilTime(timeStamp: e.endDate)
      && DYXDateTimeUtils.onWeek(e.week)
    ).toList();
    // 班级的(只有学生添加)
    if (userVM.dYXRole == DYXRole.student) {
      stickyHeaderList.add(DYXSliverStickyHeader(
        slivers: SliverGrid.count(
          crossAxisCount: 3,
          crossAxisSpacing: 0.9,
          children: filterClass(data).map((e) => buildItem(regularItem: e)).toList(),
        ), title: "班级",
      ));
    }

    // 个人
    /// 进行中
    stickyHeaderList.add(DYXSliverStickyHeader(
      slivers: SliverGrid.count(
        crossAxisCount: 3,
        crossAxisSpacing: 0.9,
        children: filterGoOn(data).map((e) => buildItem(regularItem: e, conduct: true)).toList(),
      ), title: "进行中",
    ));
    /// 已结束
    stickyHeaderList.add(DYXSliverStickyHeader(
      slivers: SliverGrid.count(
        crossAxisCount: 3,
        crossAxisSpacing: 0.9,
        children: filterEnd(data).map((e) => buildItem(regularItem: e)).toList(),
      ), title: "已结束",
    ));
    /// 未开始
    stickyHeaderList.add(DYXSliverStickyHeader(
      slivers: SliverGrid.count(
        crossAxisCount: 3,
        crossAxisSpacing: 0.9,
        children: filterNotStart(data).map((e) => buildItem(regularItem: e)).toList(),
      ), title: "未开始",
    ));
    return stickyHeaderList;
  }

  /// 过滤，只要班级的数据
  List<Result> filterClass(List<Result> results) => results.where((element) =>
    element.regular.clazz!=null &&
    DYXDateTimeUtils.onTime(startTime: element.startTime, endTime: element.endTime) // 在这个时间段内
  ).toList();

  /// 过滤，进行中的签到
  List<Result> filterGoOn(List<Result> results) => results.where((element) =>
    element.regular.clazz==null
    && DYXDateTimeUtils.getNowTimeStamp() >= DYXDateTimeUtils.floorTime(timeStamp: element.startDate)
    && DYXDateTimeUtils.getNowTimeStamp() <= DYXDateTimeUtils.ceilTime(timeStamp: element.endDate)
    && DYXDateTimeUtils.onTime(startTime: element.startTime, endTime: element.endTime) // 在这个时间段内
  ).toList();

  /// 过滤，已结束的签到
  List<Result> filterEnd(List<Result> results) => results.where((element) =>
    DYXDateTimeUtils.floorTime() >= DYXDateTimeUtils.getNowTimeStamp(now: widget.now) // 查看以前的签到
    || (
        DYXDateTimeUtils.toTime() > DYXDateTimeUtils.toTime(time: element.endTime)
        && DYXDateTimeUtils.floorTime() == DYXDateTimeUtils.floorTime(timeStamp: widget.now.millisecondsSinceEpoch ~/ 1000)
    ) // 今天的时间超过
  ).toList();

  /// 过滤，未开始的签到
  List<Result> filterNotStart(List<Result> results) => results.where((element) =>
    DYXDateTimeUtils.floorTime() < DYXDateTimeUtils.getNowTimeStamp(now: widget.now) // 查看未来的
    || DYXDateTimeUtils.toTime() < DYXDateTimeUtils.toTime(time: element.startTime) // 时间未开始
  ).toList();

  /// item
  Widget buildItem({
    @required Result regularItem,
    bool conduct = false
  }) => GestureDetector(
    child: Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5.px))),
      margin: EdgeInsets.all(5.px),
      padding: EdgeInsets.all(5.px),
      child: Column(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(regularItem.regular.image),),
          SizedBox(height: 2.px,),
          Text(regularItem.regular.title),
          SizedBox(height: 2.px,),
          Text("${DYXDateTimeUtils.getNowTime(timeStamp: regularItem.startTime)}~${DYXDateTimeUtils.getNowTime(timeStamp: regularItem.endTime)}"),
          SizedBox(height: 2.px,),
          Text("已坚持打卡0天")
        ],
      ),
    ),
    onTap: () {
      if (conduct) {
        Navigator.pushNamed(context, DYXRegularContentEditPage.routeName, arguments: regularItem);
      } else {
        DYXToast.showToast("暂时无法签到");
      }
    },
  );
}
