import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/viewmodel/user_view_model.dart';
import 'package:student_management/ui/shared/image/image_network.dart';

import 'home_content.dart';

class DYXHomePage extends StatefulWidget {
  static const String routeName = "/home";

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
            Scaffold.of(context).openDrawer();
          },
        ),
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
      backgroundImage: AssetImage("assets/images/xzdl.png"),
      backgroundColor: Colors.white,
    );
  }
}
