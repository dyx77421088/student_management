import 'package:flutter/material.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/ui/pages/personal/work/work.dart';
class DYXSelectClass extends StatefulWidget {
  final List<DYXItem> list;

  DYXSelectClass(this.list);

  @override
  _DYXSelectClassState createState() => _DYXSelectClassState();
}

class _DYXSelectClassState extends State<DYXSelectClass> {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.px,
      // child: SingleChildScrollView(
        child: buildClass(),
      // ),
    );
  }

  Widget buildClass() {


    if (widget.list.length <= 0) return Text("暂无");
    // return SliverGrid.count(
    //   crossAxisCount: list.length,
    //   children: list.map((e) => buildListTile(e.index, e.text)).toList(),
    // );
    // return Column(
    //   children: list.map((e) => buildListTile(e.index, e.text)).toList(),
    // );
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => buildListTile(index, widget.list[index].text),
      itemCount: widget.list.length,
    );
  }

  /// build单个radio
  Widget buildListTile(index, text) {
    return ListTile(
      leading: Checkbox(
        value: widget.list[index].check,
        onChanged: (b) {
          setState(() {
            widget.list[index].check = b;
          });
        },
      ),
      title: Text(text),
    );
  }
}

