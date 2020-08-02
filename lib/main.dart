import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/viewmodel/count_down_view_model.dart';
import 'package:student_management/core/viewmodel/user_view_model.dart';
import 'ui/shared/theme/app_theme.dart';
import 'ui/pages/main/main.dart';
import 'core/router/route.dart';
import 'ui/shared/size_fit.dart';

void main() {
  DYXSizeFit.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => DYXCountDownViewModel(),),
        ChangeNotifierProvider(create: (ctx) => DYXUserViewModel(),),
      ],
      child: MyApp(),
    )

  );
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

