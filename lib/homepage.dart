import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterloginapp/loginpage.dart';
import 'cart.dart';
import 'orders.dart';
import 'account.dart';
import 'changepassword.dart';

var u;
class homepage extends StatefulWidget {
  homepage(FirebaseUser user){
    u=user;
  }
  @override
  _homepageState createState() => _homepageState();
}
class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('All Stores')),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.local_grocery_store,
              ),onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => cart()));
              },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: u.photoUrl!=null
                  ? ClipOval(child: Image.network(u.photoUrl,width: 100,height: 100,fit: BoxFit.cover,))
                  : CircleAvatar(child: Icon(Icons.account_circle),radius: 50,),
              accountName: Text(u.displayName),
              accountEmail: Text(u.email),
            ),
            GestureDetector(child:ListTile(title: Text('My Account'), trailing: Icon(Icons.account_circle),onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => account()));
            },)),
            GestureDetector(child:ListTile(title: Text('Manage Password'), trailing: Icon(Icons.settings),onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => changepassword()));
            },)),
            GestureDetector(child:ListTile(title: Text('My Orders'), trailing: Icon(Icons.list),onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => orders()));
            },)),
            GestureDetector(child:ListTile(title: Text('My Cart'), trailing: Icon(Icons.local_grocery_store),onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => cart()));
            },)),
            Padding(
              padding: const EdgeInsets.all(10),
              child: RaisedButton(child: Text('Logout'),onPressed: (){
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => loginpage())
                );
              },),
            )
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(Icons.location_on),Text('Ghaziabad')],
            ),
          ),
          ListTile(
            leading: Icon(Icons.business,size: 40,),
            title: Text('Aggarwal Sweets'),
            subtitle: Text('A-10, Ghazibad'),
            trailing: Icon(Icons.phone,color: Colors.blue),
          ),
          ListTile(
            leading: Icon(Icons.business,size: 40,),
            title: Text('Sharma Mart'),
            subtitle: Text('D-55, Ghaziabad'),
            trailing: Icon(Icons.phone,color: Colors.blue),
          ),
          ListTile(
            leading: Icon(Icons.business,size: 40,),
            title: Text('Gupta Groceries'),
            subtitle: Text('A-20, Ghazibad'),
            trailing: Icon(Icons.phone,color: Colors.blue,),
          ),
        ],
      ),
    );
  }
}
