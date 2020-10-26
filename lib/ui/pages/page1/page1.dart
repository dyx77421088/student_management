import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:student_management/ui/shared/sliver_sticky_header/sliver_sticky_header_model.dart';

class DYXPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Sticky Headers'),
      ),
      body: DYXSliverStickyHeaderModel(
        slivers: getData(),
      ),
    );
  }

  List<DYXSliverStickyHeaderModelItem> getData() {
    List<DYXSliverStickyHeaderModelItem> list = [];
    for (int i = 0; i < 10; ++i)
      list.add(DYXSliverStickyHeaderModelItem(
          title: "hhh",
          items: [
            Text("张2"),
            Text("张3"),
            Text("张11"),
            Text("张22"),
          ]
      ));
    return list;
  }
}


