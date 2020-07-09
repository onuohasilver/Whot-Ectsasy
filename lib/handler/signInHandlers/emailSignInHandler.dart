import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whot/gameLogic/multiPlayerProvider.dart';

final Firestore _firestore = Firestore.instance;

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
signUpWithEmail(MultiPlayerData appData) async {
  final authResult = await firebaseAuth.createUserWithEmailAndPassword(
      email: appData.userEmail, password: appData.userPassword);
  final currentUser = await firebaseAuth.currentUser();
  if (authResult != null) {
    appData.setCurrentUser(currentUser.uid);
    _firestore.collection('users').document(currentUser.uid).setData(
      {
        'userid': currentUser.uid,
        'username': appData.userName,
        'avatar': appData.avatar,
        'friends': [],
        'activeGames':[]
      },
    );
  }

  return currentUser;
}
