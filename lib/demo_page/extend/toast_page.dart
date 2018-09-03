import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_is_easy/utils/screen_adaptation.dart';
import 'package:flutter_is_easy/widgets/smart_flutter.dart';
import 'package:quiver/iterables.dart';

class ToastPage extends StatelessWidget {
  static var routeName = "/toastPage";

  @override
  Widget build(BuildContext context) {
//    var list = new List<int>.generate(10, (i) => i + 1);
//    print(list);
//    var list = range(1, 100).toList();
//    print(list);
    return Scaffold(
      appBar: AppBar(
        title: Text("Toast"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: RaisedButton(
              child: Text("toast 底部(默认)"),
              onPressed: () {
                SmartFlutter.of(context)
                    .toast("测试" + Random().nextInt(10).toString());
              },
            ),
          ),
          ListTile(
            title: RaisedButton(
              child: Text("toast 中间"),
              onPressed: () {
                SmartFlutter.of(context).toast(
                    "测试" + Random().nextInt(10).toString(), Alignment.center);
              },
            ),
          ),
          ListTile(
            title: RaisedButton(
              child: Text("toast 顶部"),
              onPressed: () {
                SmartFlutter.of(context).toast(
                    "测试" + Random().nextInt(10).toString(),
                    Alignment.topCenter);
              },
            ),
          ),
          ListTile(
            title: RaisedButton(
              child: Text("自定义Toast样式"),
              onPressed: () {
                SmartFlutter.of(context).toast(
                  Container(
                    child: Text("自定义Toast样式"),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(
                        color: Colors.red,
                        width: dp(5),
                      ),
                    ),
                    margin: EdgeInsets.all(dp(50)),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
