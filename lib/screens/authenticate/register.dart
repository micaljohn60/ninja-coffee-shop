import 'package:flutter/material.dart';
import 'package:ninja_coffee_shop/screens/authenticate/sign_in.dart';
import 'package:ninja_coffee_shop/services/auth.dart';
import 'package:ninja_coffee_shop/shared/loading.dart';


class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();


  String email = "";
  String password = "";
  String error = "";

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text("Register to Ninja Coffee"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: ()=> widget.toggleView(), 
              icon: Icon(Icons.person), label: Text("Log In"))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter an Email" : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  decoration: InputDecoration(hintText: "Enter Your Email"),

                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  decoration: InputDecoration(hintText: "Enter Your Password"),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  onPressed: () async{
                    if(_formkey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmail(email, password); 
                      if(result == null){
                        setState(() {
                        loading = false;                        
                      });
                      }
                    }                                       
                  },
                  color: Colors.pink[400],
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
