import 'package:flutter/material.dart';
import 'package:ninja_coffee_shop/models/ninja.dart';
import 'package:provider/provider.dart';

import 'Ninja_Tile.dart';

class NinjaLists extends StatefulWidget {
  @override
  _NinjaListsState createState() => _NinjaListsState();
}

class _NinjaListsState extends State<NinjaLists> {
  @override
  Widget build(BuildContext context) {
    final ninjas = Provider.of<List<Ninja>>(context) ?? [];

    return ListView.builder(
      itemCount: ninjas.length,
      itemBuilder: (context,index){
        return Ninja_Tile(ninja: ninjas[index]);
      }

      );
  }
}