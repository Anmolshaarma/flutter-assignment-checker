import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterloginapp/signuppage.dart';
import 'homepage.dart';
import 'package:toast/toast.dart';

class loginpage extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}
class _loginState extends State<loginpage> {
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("ShopComm")),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Center(child: Image.network('https://cdn3.vectorstock.com/i/1000x1000/98/22/logo-for-grocery-store-vector-21609822.jpg',width: 200,height: 200,))
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: (value){_email=value;},
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: (value){_password=value;},
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: RaisedButton(
                    child: Text('Login'),
                    onPressed: ()async{
                      if(_email==null||_password==null||_email==''||_password==''){
                        Toast.show('Please Provide all the details', context);
                      }
                      else{
//                      print("Email: "+_email);
//                      print("Password: "+_password);
                        try{
                          var user= (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
                          print('Signed In');
                          Toast.show('Login Successful', context);
                          print(user.displayName);
                          print(user.email);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => homepage(user))
                          );
                        }
                        catch(e){
                          Toast.show(e, context);
                        }
                      }
                    },
                  ),
                ),
                GestureDetector(
                  child: Center(child: Text('New User? Create an account now')),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => signuppage())
                    );
                  },
                )
              ],
            ),
          ),
        )
      );
  }
}