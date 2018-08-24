import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SmartFlutter(
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MyHomePage(),
        routes: {
          TabsPage.routeName: (context) => new TabsPage(),
          DemoPage.routeName: (context) => new DemoPage(),
        },
      ),
    );
  }
}

class SmartFlutter extends StatefulWidget {
  final Widget child;

  SmartFlutter({Key key, this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SmartFlutterState();
  }

  static _SmartFlutterState of(BuildContext context, {bool nullOk: false}) {
    assert(nullOk != null);
    assert(context != null);
    final _SmartFlutterState result =
        context.ancestorStateOfType(const TypeMatcher<_SmartFlutterState>());
    if (nullOk || result != null) return result;
    throw new FlutterError(
        'Scaffold.of() called with a context that does not contain a Scaffold.\n'
        'No Scaffold ancestor could be found starting from the context that was passed to Scaffold.of(). '
        'This usually happens when the context provided is from the same StatefulWidget as that '
        'whose build function actually creates the Scaffold widget being sought.\n'
        'There are several ways to avoid this problem. The simplest is to use a Builder to get a '
        'context that is "under" the Scaffold. For an example of this, please see the '
        'documentation for Scaffold.of():\n'
        '  https://docs.flutter.io/flutter/material/Scaffold/of.html\n'
        'A more efficient solution is to split your build function into several widgets. This '
        'introduces a new context from which you can obtain the Scaffold. In this solution, '
        'you would have an outer widget that creates the Scaffold populated by instances of '
        'your new inner widgets, and then in these inner widgets you would use Scaffold.of().\n'
        'A less elegant but more expedient solution is assign a GlobalKey to the Scaffold, '
        'then use the key.currentState property to obtain the ScaffoldState rather than '
        'using the Scaffold.of() function.\n'
        'The context used was:\n'
        '  $context');
  }
}

class _SmartFlutterState extends State<SmartFlutter> {
  String toastMsg = "";

  @override
  Widget build(BuildContext context) {
//    child: new Text("Hello World!", textDirection: TextDirection.ltr)
//    return WidgetsApp(
//      color: Colors.deepOrange,
//      builder: (c, w) {
//        return Stack(
//          children: <Widget>[
//            widget.child,
//            Text("123"),
//          ],
//        );
//      },
//    );
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            widget.child,
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: buildToastView(),
              ),
              left: 0.0,
              top: 0.0,
              right: 0.0,
              bottom: 0.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildToastView() {
    return IgnorePointer(
      child: Container(
        child: Text(
          toastMsg,
          style: TextStyle(fontSize: 15.0, color: Color(0xFFffffff)),
        ),
        decoration: BoxDecoration(
          color: Color(0x99000000),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(90.0),
      ),
      ignoring: true,
    );
  }

  toast(String msg) {
    setState(() {
      toastMsg = msg;
    });
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
          new ListTile(
            title: new Text("Home Body"),
          ),
          new ListTile(
            title: new RaisedButton(
                child: new Text("Route to Tabs".toUpperCase()),
                onPressed: () {
                  Navigator.of(context).pushNamed(TabsPage.routeName);
                }),
          ),
          new ListTile(
            title: new RaisedButton(
                child: new Text("Route to Demo".toUpperCase()),
                onPressed: () {
                  Navigator.of(context).pushNamed(DemoPage.routeName);
                }),
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

class DemoPage extends StatefulWidget {
  static String routeName = "/demoPage";

  @override
  State<StatefulWidget> createState() {
    return _DemoPageState();
  }
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("demo"),
      ),
      body: Container(
        child: ListView(
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
      ),
    );
  }
}
