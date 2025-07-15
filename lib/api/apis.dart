import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:wcycle_bd/model/users.dart';

class Apis {
  final firebaseAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  static const String googleMapKey = "AIzaSyBCdMD9ZALTAo5sAtmhBM50PI-lWb_uq1E";

  double deviceWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  double deviceHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  User get currentUser => firebaseAuth.currentUser!;

  void setUser(Map<String, dynamic> userData, String collection) async {
    await fireStore.collection(collection).doc(currentUser.uid).set(userData);
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
      email: currentUser.email.toString(),
      individual: true,
      userStatus: "Under Review",
    );

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
