import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_animation/constant/curves.dart';

class RotateAnimation extends StatefulWidget {
  const RotateAnimation({Key key}) : super(key: key);

  @override
  _RotateAnimationState createState() => _RotateAnimationState();
}

class _RotateAnimationState extends State<RotateAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  Curve _currentCurve;
  Curve _reverseCurve;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    _currentCurve = Curves.bounceIn;
    _reverseCurve = Curves.bounceOut;

    CurvedAnimation _curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: _currentCurve,
      reverseCurve: _reverseCurve,
    );

    animation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ) //.chain(CurveTween(curve: Curves.bounceIn)) (if not use _curveAnimation)
        .animate(_curvedAnimation) //can be animationController without curve
          ..addListener(() => setState(() {}))
          ..addStatusListener(
            (status) {
              _curvedAnimation.reverseCurve = _reverseCurve;
              _curvedAnimation.curve = _currentCurve;
              if (status == AnimationStatus.completed) {
                print(_curvedAnimation.reverseCurve);
                animationController.reverse();
              } else if (status == AnimationStatus.dismissed) {
                print(_curvedAnimation.curve);
                animationController.forward();
              }
            },
          );
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> curvesList = [];
    for (int i = 0; i < curves.curves.length; i++) {
      curvesList.add(
        DropdownMenuItem(
          child: Row(
            children: [
              Icon(Icons.arrow_drop_down),
              Text('${curves.curveName[i]}'),
            ],
          ),
          value: curves.curves[i],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Rotate Animation'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                "Forward Curve",
                style: TextStyle(fontSize: 18),
              ),
              DropdownButton(
                items: curvesList,
                value: _currentCurve,
                onChanged: (value) {
                  setState(() {
                    _currentCurve = value;
                  });
                },
              ),
              SizedBox(height: 16),
              Text(
                "Reverse Curve",
                style: TextStyle(fontSize: 18),
              ),
              DropdownButton(
                items: curvesList,
                value: _reverseCurve,
                onChanged: (value) {
                  setState(() {
                    _reverseCurve = value;
                  });
                },
              ),
            ],
          ),
          Center(
            child: Transform.rotate(
              angle: animation.value,
              child: FlutterLogo(
                size: MediaQuery.of(context).size.width * .3,
              ),
            ),
          ),
          SizedBox(),
          FlatButton(
            color: Colors.blue.shade500,
            child: Text(
              !animationController.isAnimating ? "Animate" : "Stop",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () {
              setState(() {
                if (animationController.isAnimating)
                  animationController.stop();
                else {
                  if (animationController.status == AnimationStatus.reverse)
                    animationController.reverse();
                  else if (animationController.status ==
                      AnimationStatus.forward) animationController.forward();
                }
              });
            },
          ),
          SizedBox(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    //will be error if call dispose after super.dispose()
    animationController.dispose();
    super.dispose();
  }
}
