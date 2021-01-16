import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';
import 'rootpage.dart';

class changepassword extends StatefulWidget {
  @override
  _changepasswordState createState() => _changepasswordState();
}

class _changepasswordState extends State<changepassword> {
  String _password;
  String _password2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Password'),),
      body:Container(
        padding: EdgeInsets.all(20),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
                onChanged: (value){_password=value;},
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Retype Password'),
                obscureText: true,
                onChanged: (value){_password2=value;},
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: RaisedButton(
                  child: Text('Update Password'),
                  onPressed: ()async{
                    if(_password2==null||_password==null||_password2==''||_password==''){
                      Toast.show("Please Provide all the details", context);
                    }
                    else if(_password!=_password2){
                      Toast.show("Passwords do not match", context);
                    }
                    else if(_password.length <8 || _password2.length<8){
                      Toast.show("Passwords Should be minimum 8 characters", context);
                    }
                    else{
                      try{
                        FirebaseUser user=(await FirebaseAuth.instance.currentUser());
                        user.updatePassword(_password);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => rootpage())
                        );
                        Toast.show('Password Updated', context);
                      }
                      catch(e){
                        Toast.show(e, context);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
