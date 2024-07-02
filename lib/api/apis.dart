import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wcycle_bd/model/users.dart';

class Apis {
  final firebaseAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  User get currentUser => firebaseAuth.currentUser!;

  void setUser(Map<String, dynamic> userData) async {
    await fireStore.collection("users").doc(currentUser.uid).set(userData);
  }

  Future<bool> userExist() async {
    return (await fireStore.collection("users").doc(currentUser.uid).get())
        .exists;
  }

  Future<void> createGoogleUser() async {
    final userInfo = Users(
        phoneNumber: currentUser.phoneNumber.toString(),
        gender: "N/A",
        imgUri: currentUser.photoURL.toString(),
        userName: currentUser.displayName.toString(),
        birthDate: "N/A",
        email: currentUser.email.toString());

    return await fireStore
        .collection("users")
        .doc(currentUser.uid)
        .set(userInfo.toJson());
  }

/*
  Future<Map<String, dynamic>?> userData() async {
    final dates =
        await Apis().fireStore.collection("users").doc(currentUser!.uid).get();
    log(jsonEncode(dates.data()));

    if (dates.exists) {
      return newdates;
    }
    return null;
  }*/
}
