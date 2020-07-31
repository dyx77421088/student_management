import 'package:flutter/material.dart';
import 'ui/shared/app_theme.dart';
import 'ui/pages/main/main.dart';
import 'core/router/route.dart';
import 'ui/shared/size_fit.dart';

void main() {
  DYXSizeFit.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: DYXAppTheme.norTheme,
      home: DYXMainPage(),
      routes: DYXRouter.routes,
      initialRoute: DYXRouter.initialRoute,
      onGenerateRoute: DYXRouter.onGenerateRoute,
      onUnknownRoute: DYXRouter.onUnknownRoute,
    );
  }
}

