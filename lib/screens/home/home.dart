import 'package:flutter/material.dart';
import 'package:ninja_coffee_shop/models/ninja.dart';
import 'package:ninja_coffee_shop/screens/home/ninja_lists.dart';
import 'package:ninja_coffee_shop/screens/home/setting_form.dart';
import 'package:ninja_coffee_shop/services/auth.dart';
import 'package:ninja_coffee_shop/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showBottomSheet(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingForm()
        );
      });
    }

    return StreamProvider<List<Ninja>>.value(
      value: DatabaseService().ninjas,
      child: Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text("Ninja Coffee Shop"),
        actions: <Widget>[
          FlatButton.icon(onPressed: () async{
            await _auth.signOut();
          }, 
          icon: Icon(Icons.person), 
          label: Text('Log out')),

          FlatButton.icon(onPressed: () => _showBottomSheet(), 
          icon: Icon(Icons.settings), 
          label: Text('Setting'))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/coffee_bg.png'
            ),
            fit: BoxFit.cover
          )
        ),
        child: NinjaLists()
        ),
    )
    );
  }
}