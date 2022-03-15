import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({required this.uid});
   
   //collection refrence
   final CollectionReference coffeeCollection = FirebaseFirestore.instance.collection('coffees');

   Future updateUserData (String sugars,String name,int strength) async {
     return await coffeeCollection.doc(uid).set({
       'sugars' : sugars,
       'name' : name,
       'strength' : strength
     });
   }
}