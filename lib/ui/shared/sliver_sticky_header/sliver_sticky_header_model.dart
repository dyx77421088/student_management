import 'package:flutter/material.dart';
import 'package:student_management/ui/shared/sliver_sticky_header/sliver_sticky_header.dart';

/// 贴于顶部模板，
class DYXSliverStickyHeaderModel extends StatelessWidget {
  final List<DYXSliverStickyHeaderModelItem> slivers;

  DYXSliverStickyHeaderModel({@required this.slivers});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: getData(),
        reverse: false,
    );
  }

  List<Widget> getData() {
    return slivers.map((e) => DYXSliverStickyHeader(title: e.title, slivers: SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, i) => e.items[i],
        childCount: e.items.length,
      ),
    ))).toList();
  }

}
class DYXSliverStickyHeaderModelItem {
  String title;
  List<Widget> items;

  DYXSliverStickyHeaderModelItem({@required this.title, @required this.items});
}
