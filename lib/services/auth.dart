import 'package:firebase_auth/firebase_auth.dart';
import 'package:ninja_coffee_shop/models/Customer.dart';
import 'package:ninja_coffee_shop/services/database.dart';


class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Customer _customerFromFirebaseUser(User customer){
    return customer !=null ? Customer(cid: customer.uid) : null ;
  }

  // auth change user stream
  Stream<Customer> get user{
    return _auth.authStateChanges().map((User user) => _customerFromFirebaseUser(user));
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
  Future signinWithEmail(String email, String password) async{
    try{
    UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    User user = result.user;
    return user;
    }catch(e){
      print(e.toString());
    }
  }

  // register with emaili and pasword
  Future registerWithEmail(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      await DatabaseService(uid : user.uid).updateUserDate('0', 'dummy name', 100);
      return _customerFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
    }
    
  }
  // sign out 
  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      
    }
  }
}