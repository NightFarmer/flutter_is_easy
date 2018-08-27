import 'package:flutter/material.dart';
import 'package:flutter_is_easy/consts/themes.dart';
import 'package:flutter_is_easy/widgets/smart_flutter.dart';

class ChangeThemePage extends StatelessWidget {
  static var routeName = "/changeThemePage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("修改主题"),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              title: Text("主题1"),
              onTap: () {
                SmartFlutter.of(context).appTheme = Themes.blue(context);
              },
            ),
            ListTile(
              title: Text("主题2"),
              onTap: () {
                SmartFlutter.of(context).appTheme = Themes.red(context);
              },
            ),
            ListTile(
              title: Text("主题3"),
              onTap: () {
                SmartFlutter.of(context).appTheme = Themes.black(context);
              },
            )
          ],
        ).toList(),
      ),
    );
  }
}
