import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  static var routeName = "/animationPage";

  @override
  State<StatefulWidget> createState() {
    return _AnimationPageState();
  }
}

class _AnimationPageState
    extends State<AnimationPage> //    with SingleTickerProviderStateMixin {
    with
        TickerProviderStateMixin {
  Animation<double> animation1;
  AnimationController controller1;
  AnimationStatus status1;

  Animation<double> animation2;
  AnimationController controller2;

  Animation<double> animation3;
  AnimationController controller3;

  Animation<double> animation4;
  AnimationController controller4;

//  Animation<double> animation51;
//  Animation<double> animation52;
  AnimationController controller5;
  Animation<double> curveAnimation1;

  Animation<double> animation6;
  AnimationController controller6;

  @override
  void initState() {
    super.initState();
    controller1 = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation1 = new Tween(begin: 50.0, end: 100.0).animate(controller1)
      ..addListener(() {
        setState(() {
          //空着 ，但是强制刷新页面，每帧调用
        });
      })
      ..addStatusListener((status) {
        setState(() {
          this.status1 = status;
        });
      });

    //=====
    controller2 = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation2 = new Tween(begin: 50.0, end: 100.0).animate(controller2);

    //=====
    controller3 = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation3 = new Tween(begin: 50.0, end: 100.0).animate(controller3)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller3.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller3.forward();
        }
      });

    //=====
    controller4 = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation4 = new Tween(begin: 50.0, end: 100.0).animate(controller4);

    //======
    controller5 = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    curveAnimation1 =
        new CurvedAnimation(parent: controller5, curve: Curves.easeIn);
//    curveAnimation1.addListener(() {
//      setState(() {});
//    });
//    animation51 =
//        new Tween(begin: 50.0, end: 100.0).animate(curveAnimation1); //尺寸
//    animation52 =
//        new Tween(begin: 1.0, end: 0.3).animate(curveAnimation1); //透明度

    //=====
    controller6 = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    var curveAnimation2 = new CurvedAnimation(
      parent: controller6,
      curve: Curves.elasticOut,
    );
    curveAnimation2.addListener(() {
      setState(() {});
    });
    animation6 = new Tween(begin: 0.0, end: 100.0).animate(curveAnimation2);
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("动画"),
      ),
      body: ListView(
        children: ListTile.divideTiles(context: context, tiles: [
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Animation<double>"),
                  Text("${status1}"),
                ],
              ),
              GestureDetector(
                child: Container(
                  width: animation1.value,
                  height: animation1.value,
                  color: Colors.orange,
                  child: FlutterLogo(),
                ),
                onTap: () {
                  controller1.reset();
                  controller1.forward();
                },
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text("AnimatedWidget"),
              AnimatedWidgetDemo(animation: animation2),
              GestureDetector(
                child: AnimatedWidgetDemo(animation: animation2),
                onTap: () {
                  controller2.reset();
                  controller2.forward();
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text("反复循环"),
              GestureDetector(
                child: AnimatedWidgetDemo(
                  animation: animation3,
                ),
                onTap: () {
                  if (controller3.isAnimating) {
                    controller3.stop();
                  } else {
                    controller3.forward();
                  }
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text("AnimatedBuilder"),
              GestureDetector(
                child: AnimatedBuilderDemo(
                  animation: animation4,
                  child: FlutterLogo(),
                ),
                onTap: () {
                  controller4.reset();
                  controller4.forward();
                },
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text("两种动画同时执行evaluate"),
              GestureDetector(
//                child: Opacity(
//                  opacity: animation52.value,
//                  child: Container(
//                    width: animation51.value,
//                    height: animation51.value,
//                    color: Colors.blue,
//                    child: FlutterLogo(),
//                  ),
//                ),
                child: EvaluateDemo(
                  animation: curveAnimation1,
                ),
                onTap: () {
                  controller5.reset();
                  controller5.forward();
                },
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text("Curve"),
              GestureDetector(
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.lime,
                  child: FlutterLogo(),
                  margin: EdgeInsets.only(left: animation6.value),
                ),
                onTap: () {
                  controller6.reset();
                  controller6.forward();
                },
              )
            ],
          )
        ]).toList(),
      ),
    );
  }
}

class AnimatedWidgetDemo extends AnimatedWidget {
  AnimatedWidgetDemo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
      height: animation.value,
      width: animation.value,
      child: new FlutterLogo(),
      color: Colors.teal,
    );
  }
}

class AnimatedBuilderDemo extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  AnimatedBuilderDemo({this.child, this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child_to_build) {
        return Container(
          color: Colors.deepOrange,
          height: animation.value,
          width: animation.value,
          child: child_to_build,
        );
      },
    );
  }
}

class EvaluateDemo extends AnimatedWidget {
  final Tween<double> _opacityTween = new Tween(begin: 1.0, end: 0.3);
  final Tween<double> _sizeTween = new Tween(begin: 50.0, end: 100.0);

  EvaluateDemo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(
        color: Colors.blue,
        width: _sizeTween.evaluate(animation),
        height: _sizeTween.evaluate(animation),
        child: new FlutterLogo(),
      ),
    );
  }
}
