import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  // sign in method using email/password
  //sign in method anonymous
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get userStm{
    return _auth.authStateChanges();
  }
  // for sign in user w el type FUTUREEEE
  Future signinAnon() async{
    try{

      UserCredential result=await _auth.signInAnonymously();
      return result.user;

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //Register with Email and password

  Future registerwithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future SignInwithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

// for sign OUT user w el type FUTUREEEE
  Future signout() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

//Save User Credentials

Future<void> saveUserData(String name, String email) async{
    User? user = _auth.currentUser; //currentUser->retrieves the currently signed-in user in Firebase. It returns a User object

   if(user !=null){
     String uid = user.uid;
     FirebaseFirestore.instance.collection('users').doc(uid).set({
       'name' : name,
       'email' : email,
     });
   }
}
  Future<DocumentSnapshot> getUserData() async{
    User? user = _auth.currentUser; //currentUser->retrieves the currently signed-in user in Firebase. It returns a User object

    if(user !=null){
      String uid = user.uid;
      return FirebaseFirestore.instance.collection('users').doc(uid).get();
    }

    return Future.error("No User Signed In");
  }
}