import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String appName = "WCycleBD";
Color kDefaultColor = const Color.fromARGB(208, 26, 41, 65);
final firebaseAuth = FirebaseAuth.instance;
final currentUser = firebaseAuth.currentUser!.uid;
