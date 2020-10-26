import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';

/// 贴于顶部
class DYXSliverStickyHeader extends StatefulWidget {
  final String title;
  final Widget slivers;


  DYXSliverStickyHeader({@required this.title, @required this.slivers});

  @override
  _DYXSliverStickyHeaderState createState() => _DYXSliverStickyHeaderState();
}

class _DYXSliverStickyHeaderState extends State<DYXSliverStickyHeader> {
  bool isOpen = true;
  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader.builder(
      builder: (context, state) => GestureDetector(
        child: Container(
          height: 60.0,
          color: (state.isPinned ? DYXColors.blue[300] : DYXColors.blue[200])
              .withOpacity(1.0 - state.scrollPercentage),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerLeft,
          child: Text(
            '${widget.title}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        onTap: () {setState(() {
          isOpen = !isOpen;
        });},
      ),
      sliver: isOpen ? widget.slivers : null,
    );
  }
}
