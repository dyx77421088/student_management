import 'package:flutter/material.dart';

class DYXAppTheme {
  // 公有属性
  static const double bodyText1Size = 18;
  static const double bodyText2Size = 14;

  //
  static const double subTitle1Size = 24;
  static const double subTitle2Size = 16;

  static const double headline1Size = 72;
  static const double headline2Size = 64;
  static const double headline3Size = 56;
  static const double headline4Size = 48;
  static const double headline5Size = 40;
  static const double headline6Size = 32;

  // 普通模式
  static final Color norTextColors = Colors.black87;
  static final Color subTitle1Color = Colors.black;

  static final ThemeData norTheme = ThemeData(
    primarySwatch: Colors.pink,
    canvasColor: Color.fromRGBO(255, 224, 222, 1),
    accentColor: Colors.orange,
    textTheme: TextTheme(
      bodyText1: TextStyle(fontSize: bodyText1Size, color: norTextColors),
      bodyText2: TextStyle(fontSize: bodyText2Size, color: norTextColors),
      subtitle1: TextStyle(fontSize: subTitle1Size, color: subTitle1Color),
      headline1: TextStyle(fontSize: headline1Size, color: Colors.black54),
      headline2: TextStyle(fontSize: headline2Size, color: Colors.black54),
      headline3: TextStyle(fontSize: headline3Size, color: Colors.black54),
      headline4: TextStyle(fontSize: headline4Size, color: Colors.black54),
      headline5: TextStyle(fontSize: headline5Size, color: Colors.black54),
    )
  );

  // 暗黑模式
  static final Color darkTextColors = Colors.green;

  static final ThemeData dorkTheme = ThemeData(
      primarySwatch: Colors.grey,
      textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: bodyText1Size, color: darkTextColors)
      )
  );

}