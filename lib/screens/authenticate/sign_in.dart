
import 'package:flutter/material.dart';
import 'package:ninja_coffee_shop/screens/authenticate/register.dart';
import 'package:ninja_coffee_shop/services/auth.dart';
import 'package:ninja_coffee_shop/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text("Log in to Ninja Coffee"),
        actions: <Widget>[
          FlatButton.icon(onPressed: () => widget.toggleView(), 
          icon: Icon(Icons.person), label: Text("Register"))
        ],
        ),
        body: Container(
          padding:EdgeInsets.symmetric(vertical:20,horizontal:50),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                TextFormField(
                  onChanged: (val){
                    setState(()=> email = val);
                  },decoration: InputDecoration(
                    hintText: "Enter yout Email"
                  ),
                ),

                SizedBox(height: 20.0,),
                TextFormField(
                  obscureText: true,
                  onChanged: (val){
                    setState(() => password = val);
                  },
                  decoration: InputDecoration(hintText: "Enter your Password"),
                ),

                SizedBox(height: 20.0,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () async{
                          if (_formkey.currentState.validate()){
                            setState(() => loading = true);
                            dynamic result = await _auth.signInAnon(); 

                            if (result == null){
                              setState(() {
                                loading = false;
                              });
                            }
                          }
                                             
                        },
                        child: Text("Sign In Annon"),                  
                      ),

                      RaisedButton(
                        onPressed: () async{
                          if(_formkey.currentState.validate()){
                          setState(()=> loading = true);
                          dynamic result = await _auth.signinWithEmail(email, password);

                          if(result == null){
                            setState(() {
                              loading = false;
                              
                            });
                          }
                          }
                        },
                        color: Colors.pink[400],
                        child: Text("Log In",style: TextStyle(color: Colors.white),),                  
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ),
    );
  }
}