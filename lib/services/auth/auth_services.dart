import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser(){
    return _auth.currentUser;
  }
  

  Future<UserCredential> signIn(String email, password)async{
    UserCredential userCredential =  await _auth.signInWithEmailAndPassword(
      email: email, 
      password: password,
    );
    return userCredential;
  }

  Future<UserCredential> signUp(String email, password,)async{
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
    email: email, 
    password: password,
    );
    await _firestore.collection('Users').doc(userCredential.user!.email).set(
      {
        'email': email,
        'userName' : email.split('@') [0],
        'bio': 'empty bio...',
        'uid': userCredential.user!.uid,
        'timeStamp': Timestamp.now(),
      }
    );
    return userCredential;
  }

  Future<void> logOut()async{
   await _auth.signOut();
  }
}