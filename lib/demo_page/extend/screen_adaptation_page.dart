import 'package:flutter/material.dart';
import 'package:flutter_is_easy/utils/screen_adaptation.dart';

class ScreenAdaptationPage extends StatelessWidget {
  static var routeName = "/screenAdaptationPage";

  @override
  Widget build(BuildContext context) {
    ScreenAdaptation.designWidth = 1080.0;
    ScreenAdaptation.designHeight = 1920.0;

    var one = vw(1) * 3 + vw(100 - 3) / 4 * 4;
    print("${ScreenAdaptation.screenWidth} ${one}");
    return Scaffold(
      appBar: AppBar(
        title: Text("屏幕适配"),
      ),
      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: dp(200),
                height: dp(200),
                color: Colors.orange,
                child: Text(
                  "100x100",
                  style: TextStyle(fontSize: dp(40)),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: vw(50),
                height: dp(200),
                color: Colors.green,
                child: Text(
                  "高：200，宽：屏宽的50%",
                  style: TextStyle(fontSize: dp(40)),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: dp(400),
                height: vw(50),
                color: Colors.blue,
                child: Text(
                  "宽：400\n高：屏宽的50%",
                  style: TextStyle(fontSize: dp(40)),
                ),
              )
            ],
          ),
          Wrap(
            spacing: vw(1),
            runSpacing: vw(1),
            children: ["平", "分", "屏", "幕", "的", "方", "块"]
                .map((it) => Container(
                      width: vw(100 - 3) / 4 - 0.00001,
                      //warp布局的bug，单行子元素之和刚好等于宽度的时候在某些分辨率下会被换行
                      height: vw(100 - 3) / 4,
                      color: Colors.purpleAccent,
                      child: Center(
                        child: Text(
                          it,
                          style: TextStyle(fontSize: dp(100)),
                        ),
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
