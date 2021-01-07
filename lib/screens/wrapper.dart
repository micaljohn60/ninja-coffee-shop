import 'package:flutter/material.dart';
import 'package:ninja_coffee_shop/screens/authenticate/authenticate.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Return either Home or Auth
    return Authenticate();
  }
}