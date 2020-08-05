import 'package:student_management/ui/pages/main/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:student_management/ui/shared/nav_bar/nav_bar.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';
import 'initialize_items.dart';

class DYXMainPage extends StatefulWidget {
  static const String routeName = "/";

  @override
  _DYXMainScreenState createState() => _DYXMainScreenState();
}

class _DYXMainScreenState extends State<DYXMainPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: pages,
      ),
      bottomNavigationBar: Container(
        color: DYXColors.blue[100],
        child: DYXNavBar(
          tabs: items,
          selectedIndex: _index,
          onTabChange: (index) {
            setState(() {
              _index = index;
            });
          },
        ),
      ),
      drawer: DYXMainDrawer(),
    );
  }
}
