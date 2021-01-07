import 'package:firebase_auth/firebase_auth.dart';
import 'package:ninja_coffee_shop/models/Customer.dart';


class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Customer _customerFromFirebaseUser(User customer){
    return customer !=null ? Customer(cid: customer.uid) : null ;
  }

  // sing in anon
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password

  // register with emaili and pasword

  // sign out 
}