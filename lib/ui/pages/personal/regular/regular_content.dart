import 'package:flutter/material.dart';
import 'package:student_management/core/model/regular_add_record/regular_add_record_model.dart';
import 'package:student_management/core/services/regular_add_record/regular_add_record.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/core/utils/date_time_utils.dart';
import 'package:student_management/ui/shared/refresh/easy_refresh/my_easy_refresh_model.dart';
import 'package:student_management/ui/shared/sliver_sticky_header/sliver_sticky_header.dart';
import 'package:student_management/ui/shared/sliver_sticky_header/sliver_sticky_header_model.dart';
/// 展示打卡的信息
class DYXRegularContent extends StatefulWidget {
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

  Widget buildData() =>  DYXEasyRefreshModel(
    slivers: data == null ? [] : buildDataChildren(),
    onRefresh: () async{
      data = await DYXRegularAddRecordServices.search();
      setState(() {});
    },
    onLoad: ()async{},
  );

  /// 处理数据
  List<Widget> buildDataChildren() {
    List<Widget> stickyHeaderList = [];
    int now = DYXDateTimeUtils.getNowTimeStamp();
    // 处理今天需要的打卡
    var nowData =  data.results.where((element) => // 过滤，只要几天能打卡的
        DYXDateTimeUtils.floorTime(timeStamp: element.startDate) <= now &&
        now <= DYXDateTimeUtils.ceilTime(timeStamp: element.endDate) &&
        DYXDateTimeUtils.onWeek(element.week)
    ).toList();
    // 班级的
    stickyHeaderList.add(DYXSliverStickyHeader(
      slivers: SliverGrid.count(
        crossAxisCount: 3,
        crossAxisSpacing: 0.9,
        children: nowData.where((element) => element.regular.clazz!=null).map((e) => buildItem(regularItem: e)).toList(),
      ), title: "班级",
    ));
    // 个人
    stickyHeaderList.add(DYXSliverStickyHeader(
      slivers: SliverGrid.count(
        crossAxisCount: 3,
        crossAxisSpacing: 0.9,
        children: nowData.map((e) => buildItem(regularItem: e)).toList(),
      ), title: "进行中",
    ));
    /// 已结束
    stickyHeaderList.add(DYXSliverStickyHeader(
      slivers: SliverGrid.count(
        crossAxisCount: 3,
        crossAxisSpacing: 0.9,
        children: data.results.where((element) =>
            now > DYXDateTimeUtils.ceilTime(timeStamp: element.endDate))
          .map((e) => buildItem(regularItem: e)).toList(),
      ), title: "已结束",
    ));
    /// 未开始
    stickyHeaderList.add(DYXSliverStickyHeader(
      slivers: SliverGrid.count(
        crossAxisCount: 3,
        crossAxisSpacing: 0.9,
        children: data.results.where((element) =>
        DYXDateTimeUtils.floorTime(timeStamp: element.startDate) <= now &&
            now <= DYXDateTimeUtils.ceilTime(timeStamp: element.endDate) &&
            !DYXDateTimeUtils.onWeek(element.week) ||
            DYXDateTimeUtils.floorTime(timeStamp: element.startDate) > now)
            .map((e) => buildItem(regularItem: e)).toList(),
      ), title: "未开始",
    ));
    return stickyHeaderList;
  }

  Widget buildItem({
    @required Result regularItem,
  }) => Container(
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5.px))),
    margin: EdgeInsets.all(5.px),
    padding: EdgeInsets.all(5.px),
    child: GestureDetector(
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
      onTap: () { // 点击
        // Navigator.pushNamed(context, DYXRegularAddRecordPage.routeName, arguments: regularItem);
      },
    ),
  );
}
