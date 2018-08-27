import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_is_easy/demo_page/extend/toast_page.dart';
import 'package:flutter_is_easy/demo_page/normal/deviceInfo_page.dart';
import 'dart:math';

import 'package:flutter_is_easy/demo_page/extend/screen_adaptation_page.dart';
import 'package:flutter_is_easy/widgets/smart_flutter.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmartFlutter(
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          platform: TargetPlatform.iOS,
        ),
        home: new MyHomePage(),
        routes: {
          TabsPage.routeName: (context) => new TabsPage(),
//          DemoPage.routeName: (context) => new DemoPage(),
          DeviceInfoPage.routeName: (context) => new DeviceInfoPage(),
          ScreenAdaptationPage.routeName: (context) =>
              new ScreenAdaptationPage(),
          ToastPage.routeName: (context) => new ToastPage(),
        },
      ),
    );
  }
}

/// HOME
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Page"),
      ),
      body: new ListView(
        children: <Widget>[
//          new ListTile(
//            title: new RaisedButton(
//                child: new Text("Route to Tabs".toUpperCase()),
//                onPressed: () {
//                  Navigator.of(context).pushNamed(TabsPage.routeName);
//                }),
//          ),
          new ListTile(
            title: new Text("Route to Tabs"),
            onTap: () {
              Navigator.of(context).pushNamed(TabsPage.routeName);
            },
          ),
          new ListTile(
            title: new Text("Toast"),
            onTap: () {
              Navigator.of(context).pushNamed(ToastPage.routeName);
            },
          ),
          new ListTile(
            title: new Text("设备信息"),
            onTap: () {
              Navigator.of(context).pushNamed(DeviceInfoPage.routeName);
            },
          ),
          new ListTile(
            title: new Text("屏幕适配"),
            onTap: () {
              Navigator.of(context).pushNamed(ScreenAdaptationPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}

/// Tabs
class TabsPage extends StatefulWidget {
  static String routeName = "/tabsPage";

  @override
  _TabsPageState createState() => new _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          bottom: new TabBar(
            tabs: [
              new Tab(icon: new Icon(Icons.directions_car), text: "Cars"),
              new Tab(
                  icon: new Icon(Icons.directions_transit), text: "Transit"),
            ],
          ),
          title: new Text('Tabs'),
        ),
        body: new TabBarView(
          children: [
            new CarsTab(
              scaffoldKey: _scaffoldKey,
            ),
            new TransitTab(
              scaffoldKey: _scaffoldKey,
            ),
          ],
        ),
      ),
    );
  }
}

/// Cars
class CarsTab extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  CarsTab({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _CarsTabState createState() => new _CarsTabState();
}

class _CarsTabState extends State<CarsTab> {
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new SwitchListTile(
            title: new Text("Enable Cars Route"),
            value: _enabled,
            onChanged: (bool value) {
              setState(() {
                _enabled = value;
              });

              if (value) {
                var snackbar = new SnackBar(content: new Text("Cars enabled"));
                widget.scaffoldKey.currentState.showSnackBar(snackbar);
              }
            }),
      ],
    );
  }
}

/// Transit
class TransitTab extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  TransitTab({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _TransitTabState createState() => new _TransitTabState();
}

class _TransitTabState extends State<TransitTab> {
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new SwitchListTile(
            title: new Text("Enable Transit Route"),
            value: _enabled,
            onChanged: (bool value) {
              setState(() {
                _enabled = value;
              });

              if (value) {
                var snackbar =
                    new SnackBar(content: new Text("Transit enabled"));
                widget.scaffoldKey.currentState.showSnackBar(snackbar);
              }
            }),
      ],
    );
  }
}
