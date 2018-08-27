import 'package:flutter/material.dart';
import 'package:flutter_is_easy/utils/screen_adaptation.dart';

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
          style: TextStyle(fontSize: dpx(13.5), color: Color(0xFFffffff)),
        ),
        decoration: BoxDecoration(
          color: Color(0xAA000000),
          borderRadius: BorderRadius.all(Radius.circular(dpx(10.0))),
        ),
        padding: EdgeInsets.all(dpx(15.5)),
        margin: EdgeInsets.symmetric(
          vertical: dpx(70.0),
          horizontal: dpx(50.0),
        ),
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
