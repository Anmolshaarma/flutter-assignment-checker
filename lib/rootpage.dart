import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterloginapp/homepage.dart';
var u;
class rootpage extends StatefulWidget {
  @override
  _rootpageState createState() => _rootpageState();
}
enum AuthStatus{
  signedin,
  notsignedin,
}
class _rootpageState extends State<rootpage> {
  AuthStatus _authStatus =AuthStatus.notsignedin;
  initState(){
    super.initState();
    var user=FirebaseAuth.instance.currentUser().then((userId) {
      u=userId;
      print("Logged in user:"+userId.email);
      setState(() {
        _authStatus=userId==null?AuthStatus.notsignedin:AuthStatus.signedin;
      });
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    switch(_authStatus){
      case AuthStatus.notsignedin:
        return new loginpage();
      case AuthStatus.signedin:
        return new homepage(u);
    }
  }
}
