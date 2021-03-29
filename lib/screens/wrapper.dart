import 'package:flutter/material.dart';
import 'package:ninja_coffee_shop/models/Customer.dart';
import 'package:ninja_coffee_shop/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Return either Home or Auth
    final user = Provider.of<Customer>(context);
    print(user);
    if(user == null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}