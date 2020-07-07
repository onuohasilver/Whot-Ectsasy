import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whot/gameLogic/appProvider.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
Firestore _firestore=Firestore.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle(Data appData) async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult =
        await firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);

    if (currentUser != null) {
      appData.setCurrentUser(currentUser.uid);
    _firestore.collection('users').document(currentUser.uid).setData(
      {
        'userid': currentUser.uid,
        'username': appData.userName,
        'avatar': appData.avatar,
        'friends': []
      },
    );
  }



    return currentUser.uid;
    
  }