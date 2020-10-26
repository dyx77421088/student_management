import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/personal/regular/regular_content.dart';
import 'package:student_management/ui/pages/personal/regular/regular_target.dart';
import 'package:student_management/ui/shared/icon/icons.dart';

import 'regular_add/regular_add.dart';

class DYXRegularPage extends StatefulWidget {
  static const String routeName = "/DYXRegularPage";

  @override
  _DYXRegularPageState createState() => _DYXRegularPageState();
}

class _DYXRegularPageState extends State<DYXRegularPage> {
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('打卡'),
      ),
      body: IndexedStack(
        index: _index,
        children: [
          DYXRegularContent(),
          DYXRegularTarget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "添加",
        child: Icon(DYXIcons.add),
        onPressed: () {
          Navigator.pushNamed(context, DYXRegularAddPage.routeName);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            label: '打卡',
            icon: Icon(DYXIcons.calendar),
          ),
          BottomNavigationBarItem(
            label: '目标任务',
            icon: Icon(DYXIcons.target)
          )
        ],
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
