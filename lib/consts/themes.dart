import 'package:flutter/material.dart';

class Themes {
  static blue(BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.blue,
//      scaffoldBackgroundColor: Colors.white,
      platform: TargetPlatform.iOS,
//      textTheme: Theme.of(context).textTheme.apply(
//            bodyColor: Colors.pinkAccent,
//            displayColor: Colors.green,
//          ),
    );
  }

  static red(BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.red,
//      scaffoldBackgroundColor: Colors.white,
      platform: TargetPlatform.iOS,
//      textTheme: Theme.of(context).textTheme.apply(
//        bodyColor: Colors.pinkAccent,
//        displayColor: Colors.green,
//      ),
    );
  }

  static black(BuildContext context) {
    return ThemeData.dark();
    return ThemeData(
      primarySwatch: Colors.purple,
//      scaffoldBackgroundColor: Colors.white,
//      platform: TargetPlatform.iOS,
//      textTheme: Theme.of(context).textTheme.apply(
//        bodyColor: Colors.pinkAccent,
//        displayColor: Colors.green,
//      ),
    );
  }
}
