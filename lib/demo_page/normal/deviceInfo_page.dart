import 'dart:ui';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_is_easy/main.dart';

class DeviceInfoPage extends StatelessWidget {
  static var routeName = "/deviceInfoPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("设备信息"),
      ),
      body: ListView(
//        crossAxisAlignment: CrossAxisAlignment.start,
        children: ListTile
            .divideTiles(tiles: getInfo(context), color: Colors.orange)
            .toList(),
      ),
    );
  }

  List<Widget> getInfo(context) {
    return <Widget>[
//      buildRow("textScaleFactor", window.textScaleFactor),
      buildRow("本地语言", window.locale),
      buildRow("设备像素比", window.devicePixelRatio),
      buildRow("屏幕物理像素", window.physicalSize),
      buildRow("屏幕逻辑像素", MediaQuery.of(context).size),
      buildRow("SDK版本", Platform.version),
      buildRow("系统信息", Platform.operatingSystem),
      buildRow("操作系统信息", Platform.operatingSystemVersion),
      buildRow("目录分隔符", Platform.pathSeparator),
      buildRow("本地语言", Platform.localeName),
      buildRow("线程数", Platform.numberOfProcessors),
    ].map((it) {
      return ListTile(
        title: it,
      );
    }).toList();
  }

  Widget buildRow(label, info) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(label),
          width: 110.0,
        ),
        Expanded(
          child: Text("${info}"),
        )
      ],
    );
  }
}
