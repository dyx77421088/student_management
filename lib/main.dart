import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:student_management/core/view_model/count_down_view_model.dart';
import 'package:student_management/core/view_model/user_view_model.dart';
import 'core/view_model/flare_teddy_view_model.dart';
import 'ui/shared/theme/app_theme.dart';
import 'ui/pages/main/main.dart';
import 'core/router/route.dart';
import 'ui/shared/size_fit.dart';

void main() {
  DYXSizeFit.initialize();
  if (Platform.isAndroid) {
    // 透明状态栏
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => DYXCountDownViewModel(),),
        ChangeNotifierProvider(create: (ctx) => DYXUserViewModel(),),
        ChangeNotifierProvider(create: (ctx) => DYXFlareTeddyViewModel(),),
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
      debugShowCheckedModeBanner: false,
      // 支持国际化
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,

      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      locale: Locale('zh'),
    );
  }
}

