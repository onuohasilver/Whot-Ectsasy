import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whot/gameLogic/appProvider.dart';

final Firestore _firestore = Firestore.instance;

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
signUpWithEmail(String email, String password, Data appData) async {
  final authResult = await firebaseAuth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  final currentUser = await firebaseAuth.currentUser();
  if (authResult != null) {
    _firestore.collection('users').document(currentUser.uid).setData({
      'userid': currentUser.uid,
      'username': appData.userName,
      'friends': ['computer']
    });
  }

  return currentUser;
}
