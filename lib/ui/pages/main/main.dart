import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/services/work/work_search.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/pages/main/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:student_management/ui/pages/personal/news/news.dart';
import 'package:student_management/ui/pages/personal/regular/regular_add/regular_add.dart';
import 'package:student_management/ui/pages/personal/regular/regular_target.dart';
import 'package:student_management/ui/pages/personal/single_work_look/single_work_look.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/inner_drawer/inner_drawer_utils.dart';
import 'package:student_management/ui/shared/nav_bar/nav_bar.dart';
import 'package:student_management/ui/shared/theme/my_colors.dart';
import 'package:student_management/ui/shared/toast/toast.dart';
import 'initialize_items.dart';
import 'package:student_management/ui/pages/home/home.dart';
import 'package:student_management/ui/pages/page1/page1.dart';
import 'package:student_management/ui/pages/page2/page2.dart';
import 'package:student_management/ui/pages/personal/personal.dart';

class DYXMainPage extends StatefulWidget {
  static const String routeName = "/";

  @override
  _DYXMainScreenState createState() => _DYXMainScreenState();
}

class _DYXMainScreenState extends State<DYXMainPage> {
  int _index = 0;
  GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();
  List<Widget> pages;

  @override
  void initState() {
    super.initState();


    // 监听
    AwesomeNotifications().actionStream.listen(
            (receivedNotification) async{
          // print("111111111111111111111111");
          // print(receivedNotification.id);
          // DYXToast.showToast("你点击了${receivedNotification.id}");
          var data = await DYXWorkSearch.searchBySingle(id: receivedNotification.id);
          Navigator.pushNamed(context, DYXSingleWorkLookPage.routeName, arguments: data);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      DYXHomePage(_innerDrawerKey),
      DYXRegularTarget(),
      // DYXNewsPage(),
      // DYXPage1(),
      // DYXPage2(),
      DYXPersonalPage(),
    ];
    return DYXInnerDrawerUtils.buildInnerDrawer(
      context,
      key: _innerDrawerKey,
      onTapClose: true,
      scale: IDOffset.horizontal(0.65),
//      offset: IDOffset.only(left: 0.3, top: 0.2),
      colorTransitionChild: DYXColors.blue[200],
      leftAnimationType: InnerDrawerAnimation.quadratic,
      borderRadius: 30,
      backgroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment. bottomRight,
          //stops: [0.1, 0.5,0.5, 0.7, 0.9],
          colors: [
            DYXColors.blue[200],
            DYXColors.blue[100],
            DYXColors.blue[300],
            DYXColors.blue[200],
            DYXColors.blue[400],
          ],
        ),
      ),
      scaffold: Scaffold(
        body: IndexedStack(
          index: _index,
          children: this.pages,
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


        floatingActionButton: FloatingActionButton(
          tooltip: "添加",
          child: Icon(DYXIcons.add),
          onPressed: () {
            Navigator.pushNamed(context, DYXRegularAddPage.routeName);
          },
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: _index,
        //   items: [
        //     BottomNavigationBarItem(
        //       label: '打卡',
        //       icon: Icon(DYXIcons.calendar),
        //     ),
        //     BottomNavigationBarItem(
        //       label: '目标任务',
        //       icon: Icon(DYXIcons.target)
        //     )
        //   ],
        //   onTap: (index) {
        //     setState(() {
        //       _index = index;
        //     });
        //   },
        // ),







      ),
      leftChild: DYXMainDrawer(),
      // rightChild: Column(
      //   children: [
      //     Consumer<DYXUserViewModel>(
      //         builder: (ctx, userVM, child) => Material(
      //             color: Colors.transparent,
      //             child: Container(
      //               width: double.infinity,
      //               height: 960,
      //               child: Center(child: FlutterLogo(size: 100)),
      //             ))),
      //   ],
      // ),
    );
  }
}
