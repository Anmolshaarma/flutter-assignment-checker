import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:toast/toast.dart';

class signuppage extends StatefulWidget {
  @override
  _signuppageState createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  String _name;
  String _email;
  String _password;
  File _image;
  String _profileurl;

  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }
  uploadImage(File image) async {
    StorageReference reference =FirebaseStorage.instance.ref().child(image.path.toString());
    StorageUploadTask uploadTask = reference.putFile(image);
    StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    _profileurl = await downloadUrl.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                child: Center(
                    child: _image!=null?
                        ClipOval(child: Image.file(_image,width: 100,height: 100,fit: BoxFit.cover,))
                        : CircleAvatar(child: Icon(Icons.account_circle),radius: 50,)
                ),
                onTap: getImage
              ),
              Center(child: Text('Upload image')),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value){_name=value;},
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
                  child: Text('Sign up'),
                  onPressed: ()async{
                    if(_email==null||_name==null||_password==null||_image==null||_email==''||_name==''||_password==''||_image==''){
                      Toast.show('Please Provide all the details', context);
                    }
                    else if(_password.length <8){
                     Toast.show("Passwords Should be minimum 8 characters", context);
                    }
                     else{
//                    print("Name: "+_name);
//                    print("Email: "+_email);
//                    print("Password: "+_password);
                      try{
                        FirebaseUser user=(await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
                        await uploadImage(_image);
                        print("Profileurl:"+_profileurl);
                        UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
                        userUpdateInfo.displayName = _name;
                        userUpdateInfo.photoUrl=_profileurl;
                        user.updateProfile(userUpdateInfo);
//                        print('Sign Up Successful');
                        Toast.show('Sign Up Successful', context);
                        Navigator.pop(context);
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