import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ninja_coffee_shop/models/Customer.dart';
import 'package:ninja_coffee_shop/models/ninja.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  // Collection References
  final CollectionReference ninjaCollection = FirebaseFirestore.instance.collection('ninjas');

  Future<void> updateUserDate(String sugars, String name, int strength) async{
    return await ninjaCollection.doc(uid).set({
      'sugars' : sugars,
      'name' : name,
      'strength' : strength
    });
  }

  List<Ninja> _ninjalistsFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Ninja(
        name: doc.data()['name'] ?? '', 
        strength: doc.data()['strength'] ?? 0, 
        sugars: doc.data()['sugars'] ?? '' );
    }).toList();
  }

  CustomerData _customerFromSnapShot(DocumentSnapshot snapshot){
    return CustomerData(
      uid: uid,
      name: snapshot.data()['name'],
      strength: snapshot.data()['strength'],
      sugars: snapshot.data()['sugars'],
    );
  }

  Stream<List<Ninja>> get ninjas{
    return ninjaCollection.snapshots().map(_ninjalistsFromSnapshot);
  }

  Stream<CustomerData> get customerData{
    return ninjaCollection.doc(uid).snapshots().map(_customerFromSnapShot);
  }
}