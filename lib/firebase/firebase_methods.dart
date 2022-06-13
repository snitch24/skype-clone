import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skype_clone/models/app_user.dart';
import 'package:skype_clone/utils/utilities.dart';

class FirebaseMethods {
  AppUser appUser = AppUser();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<User?> getCurrentUser() async {
    User? currentUser;
    currentUser = _auth.currentUser;
    return currentUser;
  }

  Future<User?> signIn() async {
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    GoogleSignInAuthentication signInAuthentication =
        await account!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: signInAuthentication.accessToken,
        idToken: signInAuthentication.idToken);
    UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<bool> authenticateUser(User user) async {
    QuerySnapshot result = await firestore
        .collection("users")
        .where("email", isEqualTo: user.email)
        .get();
    final List<DocumentSnapshot> docs = result.docs;
    return docs.isEmpty ? true : false;
  }

  Future<void> addDataToDb(User currentUser) async {
    String userName = Utils.getUserName(currentUser.email!);
    appUser = AppUser(
      uid: currentUser.uid,
      email: currentUser.email,
      name: currentUser.displayName,
      profilePhoto: currentUser.photoURL,
      userName: userName,
    );
    firestore
        .collection('users')
        .doc(currentUser.uid)
        .set(appUser.toMap(appUser));
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }

  Future<List<AppUser>> fetchAllUsers(User user) async {
    List<AppUser> users = <AppUser>[];

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection("users").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != user.uid) {
        users.add(AppUser.fromMap(querySnapshot.docs[i].data()));
      }
    }
    return users;
  }
}
