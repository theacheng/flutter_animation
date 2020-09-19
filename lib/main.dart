import 'package:flutter/material.dart';
import 'package:flutter_animation/animations/rotate_animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimationCollection(),
    );
  }
}

class AnimationCollection extends StatelessWidget {
  const AnimationCollection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: FlutterLogo(size: 40,),
            subtitle: Text('Basic animation'),
            title: Text("Rotate Animation"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RotateAnimation(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
