import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:student_management/core/extension/int_extension.dart';

class DYXNavBar extends StatefulWidget {
  final List<GButton> tabs;
  final int selectedIndex;
  final Function onTabChange;
  final Color bgColor;

  DYXNavBar({this.tabs, this.selectedIndex=0, this.onTabChange, this.bgColor});

  @override
  _DYXNavBarState createState() => _DYXNavBarState();
}

class _DYXNavBarState extends State<DYXNavBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 8.px),
        child: GNav(
          backgroundColor: widget.bgColor,
          gap: 8,
          activeColor: Colors.white,
          iconSize: 24.px,
          padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 5.px),
          duration: Duration(milliseconds: 800),
  //        tabBackgroundColor: Colors.grey[800],
          tabBackgroundColor: Theme.of(context).appBarTheme.color,
          tabs: widget.tabs,
          selectedIndex: widget.selectedIndex,
          onTabChange: widget.onTabChange,
        ),
    ));
  }
}
