import 'package:coffee/models/user.dart';
import 'package:coffee/screens/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create myUser obj
  MyUser? _userFromFirebaseUser(User? user){
    
    // MyUser();
    return user != null ? MyUser(uid: user.uid) :  null;
  
  }

  //Auth Change user Stream
  Stream<MyUser?> get user1 {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in anon
  Future<MyUser?> signInAnon() async {
    try {
      UserCredential? result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } 
    catch (e) {
      print("Exception: $e");
      return null;
    }
  }


  // sign in with email
  Future signInWithEmailAndPassword(String email,String password) async{
    try {
      UserCredential? result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } 
    catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  //register with email
  Future registerWithEmailAndPassword(String email,String password) async{
    try {
      UserCredential? result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //Create a new Document for the User with the uid
      await DatabaseService(uid: user!.uid).updateUserData('0', 'Om Gujarathi', 100);
      return _userFromFirebaseUser(user);
    } 
    catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}