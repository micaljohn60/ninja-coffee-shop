import 'package:flutter/material.dart';
import 'package:ninja_coffee_shop/models/ninja.dart';


class Ninja_Tile extends StatelessWidget {

  final Ninja ninja;
  Ninja_Tile({this.ninja});

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/coffee_icon.png'),
            radius: 25.0,
            backgroundColor: Colors.brown[ninja.strength],
          ),
          title: Text(ninja.name),
          subtitle: Text('Takes ${ninja.sugars} sugar(s)'),
        ),
      ),
    );
  }
}