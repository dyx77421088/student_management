import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/model/regular_add_record/regular_add_record_model.dart';
import 'package:student_management/core/model/regular_clock/regular_clock_search_model.dart' as RegularClock;
import 'package:student_management/core/services/regualr_clock/regular_clock.dart';
import 'package:student_management/core/services/regular_add_record/regular_add_record.dart';
import 'package:student_management/core/utils/date_time_utils.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/shared/image/image_network.dart';
import 'package:student_management/ui/shared/refresh/easy_refresh/my_easy_refresh_model.dart';
import 'package:student_management/ui/shared/shimmer/shimmer_utils.dart';
import 'package:student_management/ui/shared/sliver_sticky_header/sliver_sticky_header.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/ui/shared/toast/toast.dart';

class DYXRegularTarget extends StatefulWidget {
  @override
  _DYXRegularTargetState createState() => _DYXRegularTargetState();
}

class _DYXRegularTargetState extends State<DYXRegularTarget> {
  DYXRegularAddRecordSearchModel data;
  int index=  1;
  /// 打卡查询
  RegularClock.DYXRegularClockSearchModel regularClockSearchModel;
  @override
  Widget build(BuildContext context) {
    print("记载！！！！！！！");
    return Scaffold(
      appBar: AppBar(title: Text("目标"),),
      body: buildData(),
    );
  }

  Widget buildData() => Consumer<DYXUserViewModel>(
    builder: (ctx, userVM, child) => DYXEasyRefreshModel(
      slivers: data == null ? [] : getData(userVM),
      onRefresh: () async{
        if (!userVM.isLogin) return;
        index = 1;
        data = await DYXRegularAddRecordServices.search();
        regularClockSearchModel = await DYXRegularClockServices.search();
        setState(() {});
      },
      onLoad: ()async{
        ++index;
        var d = await DYXRegularAddRecordServices.search(index: index);
        var d2 = await DYXRegularClockServices.search(index: index);
        if (d == null || d2 == null) {
          DYXToast.showToast("没有更多了");
          return ;
        }
        data.results.addAll(d.results);
        regularClockSearchModel.results.addAll(d2.results);
        setState(() {});
      },
    ),
  );

  List<Widget> getData(DYXUserViewModel userVM) {
    List<Widget> slivers = [];
    data.results.forEach((element) {
      if(element.regular == null) return;
      slivers.add(DYXSliverStickyHeader(
          title: element.regular?.title,
          titleWidget: Row(
            children: [
              DYXImageNetwork.avatarNetwork(url: element.regular?.image),
              // CircleAvatar(backgroundImage: NetworkImage(element.regular.image),),
              SizedBox(width: 10.px,),
              Text(element.regular.title, style: TextStyle(color: Colors.white),),

            ],
          ),
          slivers: SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.all(5.px),
                  child: Card(
                    child: Container(
                      margin: EdgeInsets.all(5.px),
                      child: Column(
                        children: [
                          buildRow("开始时间", element.startTimeStr),
                          buildRow("结束时间", element.endTimeStr),
                          buildRow("开始日期", DYXDateTimeUtils.getNowDate(timeStamp: element.startDate)),
                          buildRow("结束日期", DYXDateTimeUtils.getNowDate(timeStamp: element.endDate)),
                          buildRow("周期", element.week.toString()),
                        ],
                      ),
                    ),
                  ),
                )
              ]
            ),
          )
        )
      );
    });
    return slivers;
  }

  Widget buildRow(String left, String right) => Row (
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(left, style: TextStyle(fontSize: 16.px),),
      Text(right, style: TextStyle(fontSize: 16.px),),
    ],
  );
}
