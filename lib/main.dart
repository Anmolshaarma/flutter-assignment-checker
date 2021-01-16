import 'package:flutter/material.dart';
import 'package:flutterloginapp/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Firebase Login',
      theme: ThemeData.dark(),
      home: new splash(),
    );
  }
}


