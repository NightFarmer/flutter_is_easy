import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_is_easy/utils/screen_adaptation.dart';
import 'package:uuid/uuid.dart';

class ToastLayer extends StatefulWidget {
  ToastLayer({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ToastLayerState();
  }
}

class ToastLayerState extends State<ToastLayer>
    with SingleTickerProviderStateMixin {
  var toastMsg;
  var alignment;

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
    return toastMsg != null
        ? Align(
            alignment: alignment,
            child: _ToastView(
              animation: controller,
              showing: showing,
              child: buildToastView(),
            ),
          )
        : Container();
  }

  toast(msg, alignment) {
    var uuid = new Uuid();
    var currentToastId = uuid.v4();
    latestToastId = currentToastId;
    setState(() {
      toastMsg = msg;
      this.alignment = alignment;
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
    Widget label;
    if (toastMsg is String) {
      label = Container(
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
      );
    } else if (toastMsg is Widget) {
      label = toastMsg;
    }
    return IgnorePointer(
      child: label,
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

  final Widget child;
  final bool showing;

  _ToastView({
    Key key,
    Animation<double> animation,
    this.showing,
    this.child,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    var opacityAnimation = new CurvedAnimation(
      parent: animation,
      curve: _OpacityCurve(),
    );
    var translationAnimation = new CurvedAnimation(
      parent: animation,
      curve: _OvershootCurve(),
    );
    var translationY = 0.0;
    var opacity = 0.0;
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

class _OvershootCurve extends Curve {
  const _OvershootCurve([this.tension = 2.0]);

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

class _OpacityCurve extends Curve {
  @override
  double transform(double t) {
    return min(1.0, t * 2);
  }
}
