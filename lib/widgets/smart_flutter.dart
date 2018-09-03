import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_is_easy/utils/screen_adaptation.dart';

import 'package:uuid/uuid.dart';

class SmartFlutter extends StatefulWidget {
//  final Widget child;

  final navigatorKey;
  final home;
  final routes;
  final initialRoute;
  final onGenerateRoute;
  final onUnknownRoute;
  final navigatorObservers;
  final builder;
  final title;
  final onGenerateTitle;
  final color;
  final theme;
  final locale;
  final localizationsDelegates;
  final localeResolutionCallback;
  final supportedLocales;
  final debugShowMaterialGrid;
  final showPerformanceOverlay;
  final checkerboardRasterCacheImages;
  final checkerboardOffscreenLayers;
  final showSemanticsDebugger;
  final debugShowCheckedModeBanner;

  SmartFlutter({
    Key key,
//    this.child,
    this.navigatorKey,
    this.home,
    this.routes: const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers: const <NavigatorObserver>[],
    this.builder,
    this.title: '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.locale,
    this.localizationsDelegates,
    this.localeResolutionCallback,
    this.supportedLocales: const <Locale>[const Locale('en', 'US')],
    this.debugShowMaterialGrid: false,
    this.showPerformanceOverlay: false,
    this.checkerboardRasterCacheImages: false,
    this.checkerboardOffscreenLayers: false,
    this.showSemanticsDebugger: false,
    this.debugShowCheckedModeBanner: true,
  }) : super(key: key);

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
        'SmartFlutter.of() called with a context that does not contain a SmartFlutter.\n'
        'No SmartFlutter ancestor could be found starting from the context that was passed to SmartFlutter.of(). '
        'This usually happens when the context provided is from the same StatefulWidget as that '
        'whose build function actually creates the SmartFlutter widget being sought.\n'
        'There are several ways to avoid this problem. The simplest is to use a Builder to get a '
        'context that is "under" the SmartFlutter. For an example of this, please see the '
        'documentation for SmartFlutter.of():\n'
        '  https://docs.flutter.io/flutter/material/SmartFlutter/of.html\n'
        'A more efficient solution is to split your build function into several widgets. This '
        'introduces a new context from which you can obtain the SmartFlutter. In this solution, '
        'you would have an outer widget that creates the SmartFlutter populated by instances of '
        'your new inner widgets, and then in these inner widgets you would use SmartFlutter.of().\n'
        'A less elegant but more expedient solution is assign a GlobalKey to the SmartFlutter, '
        'then use the key.currentState property to obtain the _SmartFlutterState rather than '
        'using the SmartFlutter.of() function.\n'
        'The context used was:\n'
        '  $context');
  }
}

class _SmartFlutterState extends State<SmartFlutter> {
  ThemeData theme;

  final GlobalKey<_ToastLayerState> _toastKey =
      new GlobalKey<_ToastLayerState>();

  @override
  void initState() {
    theme = widget.theme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            MaterialApp(
              navigatorKey: widget.navigatorKey,
              home: widget.home,
              routes: widget.routes,
              initialRoute: widget.initialRoute,
              onGenerateRoute: widget.onGenerateRoute,
              onUnknownRoute: widget.onUnknownRoute,
              navigatorObservers: widget.navigatorObservers,
              builder: widget.builder,
              title: widget.title,
              onGenerateTitle: widget.onGenerateTitle,
              color: widget.color,
              theme: theme,
              locale: widget.locale,
              localizationsDelegates: widget.localizationsDelegates,
              localeResolutionCallback: widget.localeResolutionCallback,
              supportedLocales: widget.supportedLocales,
              debugShowMaterialGrid: widget.debugShowMaterialGrid,
              showPerformanceOverlay: widget.showPerformanceOverlay,
              checkerboardRasterCacheImages:
                  widget.checkerboardRasterCacheImages,
              checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
              showSemanticsDebugger: widget.showSemanticsDebugger,
              debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
            ),
            Positioned(
              child: ToastLayer(key: _toastKey),
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

  toast(String msg) {
    _toastKey.currentState?.toast(msg);
  }

  set appTheme(ThemeData theme) {
    setState(() {
      this.theme = theme;
    });
  }
}

class ToastLayer extends StatefulWidget {
  ToastLayer({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ToastLayerState();
  }
}

class _ToastLayerState extends State<ToastLayer>
    with SingleTickerProviderStateMixin {
  String toastMsg = "";

  AnimationController controller;

  var showing = false;
  var latestToastId;

  @override
  void initState() {
    controller = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: _ToastView(
        animation: controller,
        toastMsg: toastMsg,
        showing: showing,
        child: buildToastView(),
      ),
    );
  }

  toast(String msg) {
    var uuid = new Uuid();
    var currentToastId = uuid.v4();
    latestToastId = currentToastId;
    setState(() {
      toastMsg = msg;
      showing = true;
      controller.reset();
      controller.forward();
    });
    Future.delayed(Duration(milliseconds: 2000), () {
      if (currentToastId == latestToastId) {
        dismiss();
      }
    });
  }

  dismiss() {
    setState(() {
      showing = false;
      controller.reset();
      controller.forward();
    });
  }

  buildToastView() {
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _ToastView extends AnimatedWidget {
  final Tween<double> _opacityTweenShow = new Tween(begin: 0.0, end: 1.0);
  final Tween<double> _opacityTweenDismiss = new Tween(begin: 1.0, end: 0.0);
  final Tween<double> _translationTween = new Tween(begin: 0.15, end: 0.0);

  final String toastMsg;
  final Widget child;
  final bool showing;

  _ToastView({
    Key key,
    Animation<double> animation,
    this.toastMsg,
    this.showing,
    this.child,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    var opacityAnimation = new CurvedAnimation(
      parent: animation,
      curve: OpacityCurve(),
    );
    var translationAnimation = new CurvedAnimation(
      parent: animation,
      curve: OvershootCurve(),
    );
    var translationY = 0.0;
    var opacity = 1.0;
    if (showing) {
      opacity = _opacityTweenShow.evaluate(opacityAnimation);
      translationY = _translationTween.evaluate(translationAnimation);
    } else {
      opacity = _opacityTweenDismiss.evaluate(opacityAnimation);
    }
    return Opacity(
      opacity: opacity,
      child: FractionalTranslation(
        translation: Offset(0.0, translationY),
        child: child,
      ),
    );
  }
}

class OvershootCurve extends Curve {
  const OvershootCurve([this.tension = 2.0]);

  final double tension;

  @override
  double transform(double t) {
    t -= 1.0;
    return t * t * ((tension + 1) * t + tension) + 1.0;
  }

  @override
  String toString() {
    return '$runtimeType($tension)';
  }
}

class OpacityCurve extends Curve {
  @override
  double transform(double t) {
    return min(1.0, t * 2);
  }
}
