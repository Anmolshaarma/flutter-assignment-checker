import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterloginapp/rootpage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class account extends StatefulWidget {
  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<account> {
  String _name;
  File _image;
  String _profileurl;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getImage2() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
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
      appBar: AppBar(title: Text('My Account'),),
      body:Container(
        padding: EdgeInsets.all(20),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                      child: _image!=null?
                      ClipOval(child: Image.file(_image,width: 200,height: 200,fit: BoxFit.cover,))
                          : CircleAvatar(child: Icon(Icons.account_circle),radius: 100,)
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Padding(
                      child: RaisedButton(
                        child: Icon(Icons.camera_alt),
                        onPressed: getImage2,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    Padding(
                      child: RaisedButton(
                        child: Icon(Icons.image),
                        onPressed: getImage,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                  ],
                ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Update Name'),
                onChanged: (value){_name=value;},
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: RaisedButton(
                  child: Text('Save Details'),
                  onPressed: ()async{
                    FirebaseUser user=(await FirebaseAuth.instance.currentUser());
                    if(_name==null||_image==null||_name==''||_image==''){
                      Toast.show("Please Provide all the details", context,duration: 2);
                    }
                    else{
                      try{
                        FirebaseStorage.instance.ref().child(user.photoUrl).delete();
                        await uploadImage(_image);
                        UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
                        userUpdateInfo.displayName = _name;
                        userUpdateInfo.photoUrl=_profileurl;
                        await user.updateProfile(userUpdateInfo);
                        Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => rootpage())
                          );
                        Toast.show('Account Details Updated', context);
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
