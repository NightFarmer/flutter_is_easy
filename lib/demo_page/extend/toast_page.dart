import 'dart:math';

import 'package:flutter/material.dart';
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
              child: Text("toast"),
              onPressed: () {
                SmartFlutter
                    .of(context)
                    .toast("测试" + Random().nextInt(10).toString());
              },
            ),
          )
        ],
      ),
    );
  }
}
