import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wcycle_bd/screen/home_screen.dart';

class CredentialsSigninWithGoogle extends StatefulWidget {
  const CredentialsSigninWithGoogle({super.key});

  @override
  State<CredentialsSigninWithGoogle> createState() =>
      _CredentialsSigninWithGoogleState();
}

class _CredentialsSigninWithGoogleState
    extends State<CredentialsSigninWithGoogle> {
  void _onSignWithGoogle() async {
    final googleSignIn = await signInWithGoogle();

    if (googleSignIn != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        _onSignWithGoogle();
      },
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(10, 10)))),
      icon: Image.asset(
        "assets/google.png",
        width: 20,
        height: 20,
      ),
      label: const Text("Signin with Google"),
    );
  }
}
