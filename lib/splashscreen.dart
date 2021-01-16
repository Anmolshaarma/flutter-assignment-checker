import 'package:flutter/material.dart';
import 'package:flutterloginapp/rootpage.dart';
import 'package:splashscreen/splashscreen.dart';

class splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: rootpage(),
      title: new Text('ShopComm',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
        ),
      ),
      image: new Image.network('https://cdn3.vectorstock.com/i/1000x1000/98/22/logo-for-grocery-store-vector-21609822.jpg'),
      backgroundColor: Color(424242),
//      imageBackground: NetworkImage('https://cdn3.vectorstock.com/i/1000x1000/98/22/logo-for-grocery-store-vector-21609822.jpg'),
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      loaderColor: Colors.red,
    );
  }
}


