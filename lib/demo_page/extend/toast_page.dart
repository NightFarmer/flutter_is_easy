import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_is_easy/widgets/smart_flutter.dart';

class ToastPage extends StatelessWidget {
  static var routeName = "/toastPage";

  @override
  Widget build(BuildContext context) {
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
