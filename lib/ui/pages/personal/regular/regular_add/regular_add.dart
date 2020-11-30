import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/core/model/regular/regular_search_model.dart';
import 'package:student_management/core/model/regular_category/regular_category_model.dart' as regularCategory;
import 'package:student_management/core/model/regular/regular_search_model.dart' as regular;
import 'package:student_management/core/services/regular/regular_search.dart';
import 'package:student_management/core/services/regular_category/regular_category.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/pages/personal/regular/regular_add/regular_add_record/regular_add_record.dart';

/// 添加的界面
class DYXRegularAddPage extends StatefulWidget {
  static const String routeName = "/DYXRegularAddPage";

  @override
  _DYXRegularAddPageState createState() => _DYXRegularAddPageState();
}

class _DYXRegularAddPageState extends State<DYXRegularAddPage> {
//  List<regular.Result> regularList = [];
//  List<regularCategory.Result> regularCategoryList = [];
  var _futureBuilderFuture;

  @override
  void initState() {
    super.initState();
    print("开始");

    // 设置数据
    _futureBuilderFuture = setDate();
  }

  /// 设置数据
  Future setDate() async{
//    regularList = (await DYXRegularSearch.search()).results;
//    regularCategoryList = (await DYXRegularCategory.search(token: DYXUserViewModel.staticToken)).results;
    return Future.wait([DYXRegularSearch.search(), DYXRegularCategory.search(token: DYXUserViewModel.staticToken)]);
  }

  @override
  Widget build(BuildContext context) {
    print("开始!!!!!!!!!");
    return Scaffold(
      appBar: AppBar(title: Text('习惯库'),),
      body: Padding(
        padding: EdgeInsets.all(10.px),
        child: FutureBuilder(
          future: _futureBuilderFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              // 数据等待
              case ConnectionState.none: case ConnectionState.waiting :
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
            }
            print("我是数据 ========>>>  ${snapshot.data[0]}");
            print("我是数据 ========>>>  ${snapshot.data[1]}");
            /// 渲染数据
            return buildData(snapshot.data[0].results, snapshot.data[1].results);
          },
        ),
      ),
    );
  }

  /// 数据渲染
  Widget buildData(List<regular.Result> regularList, List<regularCategory.Result> regularCategoryList) {
    List<Widget> list = [];

    regularCategoryList.forEach((element) {
      list.add(SliverList(
        delegate: SliverChildListDelegate([buildTitle(element.title)]),
      ));
      List<Widget> regularData = regularList.where(
              (e) => e.regularCategory.id == element.id
      ).map<Widget>(
              (regular.Result e) => buildItem(regularItem: e)
      ).toList();

      list.add(SliverGrid.count(
        crossAxisCount: 2,
        childAspectRatio: 2,
        children: regularData,
      ));
    });
    return CustomScrollView(
      slivers: list,
    );
  }


  /// 标题
  Widget buildTitle(String title) => Row(
    children: [
      SizedBox(height: 15.px, width: 4.px,
        child: DecoratedBox(decoration: BoxDecoration(color: Colors.blue),),
      ),
      Padding(
        padding: EdgeInsets.only(left: 5.px),
        child: Text(title),
      ),
    ],
  );

  Widget buildItem({
    @required regular.Result regularItem,
  }) => Container(
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5.px))),
    margin: EdgeInsets.all(5.px),
    child: GestureDetector(
      child: ListTile(
        title: Text(regularItem.title ?? "步行"),
        subtitle: Text(regularItem.describe ?? "延年益寿之法宝", overflow: TextOverflow.ellipsis, maxLines: 1,),
//      trailing: DYXImageNetwork.avatarNetwork(url: imageUrl),
        trailing: CircleAvatar(backgroundImage: NetworkImage(regularItem.image),),
      ),
      onTap: () { // 点击
        Navigator.pushNamed(context, DYXRegularAddRecordPage.routeName, arguments: regularItem);
      },
    ),
  );
}
