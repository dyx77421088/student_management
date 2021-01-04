import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/model/work/work_search.dart';
import 'package:student_management/core/services/work/work_search.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/shared/refresh/easy_refresh/my_easy_refresh_model.dart';
import 'package:student_management/ui/shared/sliver_sticky_header/sliver_sticky_header.dart';
import 'package:student_management/core/extension/int_extension.dart';

class DYXWorkLookContent extends StatefulWidget {
  @override
  _DYXWorkContentState createState() => _DYXWorkContentState();
}

class _DYXWorkContentState extends State<DYXWorkLookContent> {
  DYXWorkSearchModel data;

  @override
  Widget build(BuildContext context) {
    return buildData();
  }

  Widget buildData() => Consumer<DYXUserViewModel>(
    builder: (ctx, userVM, child) => DYXEasyRefreshModel(
      slivers: data == null ? [] : buildDataChildren(userVM),
      onRefresh: () async{
        data = await DYXWorkSearch.search();
        setState(() {});
      },
      // onLoad: ()async{},
    ),
  );

  /// 处理数据
  List<Widget> buildDataChildren(DYXUserViewModel userVM) {
    List<Widget> stickyHeaderList = [];
    // 只查看选择的日期可以签到的

    stickyHeaderList.add(DYXSliverStickyHeader(
      isOpen: true,
      slivers: SliverGrid.count(
        crossAxisCount: 1,
        // crossAxisSpacing: 0.3,
        children: data.results.map((e) => buildItem(regularItem: e)).toList(),
      ), title: "班级(${data.results.length})",
    ));


    return stickyHeaderList;
  }

  /// item
  Widget buildItem({
    @required Result regularItem,
  }) => GestureDetector(
    child: Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5.px))),
      margin: EdgeInsets.all(5.px),
      padding: EdgeInsets.all(5.px),
      height: 50.px,
      child: Column(
        children: [
          SizedBox(height: 2.px,),
          Text(regularItem.title),
          SizedBox(height: 2.px,),
          Text(regularItem.course),
          SizedBox(height: 2.px,),
        ],
      ),
    ),
    onTap: () {

    },
  );
}
