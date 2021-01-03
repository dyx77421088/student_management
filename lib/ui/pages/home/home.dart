import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'package:student_management/ui/pages/personal/news/news.dart';
import 'package:student_management/ui/shared/icon/icons.dart';
import 'package:student_management/ui/shared/image/image_network.dart';

import 'home_content.dart';

class DYXHomePage extends StatefulWidget {
  static const String routeName = "/home";
  final GlobalKey<InnerDrawerState> innerDrawerKey;

  DYXHomePage(this.innerDrawerKey);

  @override
  _DYXHomePageState createState() => _DYXHomePageState();
}

class _DYXHomePageState extends State<DYXHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        leading: IconButton(
          icon: Consumer<DYXUserViewModel>(
            builder: (ctx, userVM, child) => buildAvatarImg(userVM),
          ),
          onPressed: () {
//            Scaffold.of(context).openDrawer();
            widget.innerDrawerKey.currentState.toggle();
          },
        ),
        actions: [
          IconButton(
              icon: Icon(DYXIcons.email, color: Colors.white,),
              onPressed: (){
                Navigator.pushNamed(context, DYXNewsPage.routeName);
              }
          )
        ],
      ),
      body: DYXHomeContent(),
    );
  }

  /// 头像
  Widget buildAvatarImg(DYXUserViewModel userVM) {
    if (userVM.avatar != null) {
      return DYXImageNetwork.avatarNetwork(url: userVM.avatar);
    }
    return CircleAvatar(
      backgroundImage: AssetImage(userVM.isLogin
          ? "assets/images/avatar_unlogin.png"
          : "assets/images/xzdl.png"),
      backgroundColor: Colors.white,
    );
  }
}
