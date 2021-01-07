
import 'package:flutter/material.dart';
import 'package:ninja_coffee_shop/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text("Sign in to Ninja Coffee"),
        ),
        body: Container(
          padding:EdgeInsets.symmetric(vertical:20,horizontal:50),
          child: RaisedButton(
            child: Text('Sign In Anon'),
            onPressed: () async{
              dynamic result = await _auth.signInAnon();
              if (result == null){
                print('Error in Sing in');
              }else{
                print('Sign in');
                print(result.uid);
              }
            }
            ),
        ),
    );
  }
}