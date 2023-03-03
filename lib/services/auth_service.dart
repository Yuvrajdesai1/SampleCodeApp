import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // ----------------- login With Email -------------
  Future loginWithEmail(
      {required String email, required String password}) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } catch (e) {
      return null;
    }
  }

  // ----------------- signUp With Email -------------

  Future signUpWithEmail(
      {required String email, required String password}) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return authResult.user != null;
    } catch (e) {
      return e;
    }
  }

  // ----------------- set user data  -------------

  void setUserData(userModel) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(userModel.toJson());
  }

  // --------------- reset password ------------
  Future resetPassword(email) async {
    _firebaseAuth
        .sendPasswordResetEmail(email: email)
        .catchError((e, stackTrace) {
      Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    });
  }

  // -------- get user data --------------
  Future getUserData() async {
    var userModel = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return userModel.data();
  }

  // -------------- set user profile ---------------
  setProfileImage(userModel) async {
    setUserData(userModel);
  }

  // --------------- change password ------------
  Future changePassword({required String password}) async {
    FirebaseAuth.instance.currentUser!.updatePassword(password).then((_) {
      return true;
    }).catchError((err) {
      return false;
    });
  }
}
