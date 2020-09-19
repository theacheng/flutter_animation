import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotateAnimation extends StatefulWidget {
  const RotateAnimation({Key key}) : super(key: key);

  @override
  _RotateAnimationState createState() => _RotateAnimationState();
}

class _RotateAnimationState extends State<RotateAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    final _curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceOut,
      reverseCurve: Curves.bounceIn,
    );

    animation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ) //.chain(CurveTween(curve: Curves.bounceIn)) (if not use _curveAnimation)
        .animate(_curvedAnimation) //can be animationController without curve
          ..addListener(() => setState(() {}))
          ..addStatusListener(
            (status) {
              if (status == AnimationStatus.completed) {
                animationController.reverse();
              } else if (status == AnimationStatus.dismissed) {
                animationController.forward();
              }
            },
          );

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rotate Animation'),
      ),
      body: Center(
        child: Transform.rotate(
          angle: animation.value,
          child: FlutterLogo(
            size: MediaQuery.of(context).size.width * .3,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}
