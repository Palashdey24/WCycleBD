import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/screen/home_screen.dart';
import 'package:wcycle_bd/utilts/global_value.dart';

class CredentialsSigninWithGoogle extends StatelessWidget {
  const CredentialsSigninWithGoogle({super.key});

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
    return await firebaseAuth.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    void onSignWithGoogle() async {
      DialogsHelper().showProgressBar(context);
      final googleSignIn = await signInWithGoogle();

      if (googleSignIn != null) {
        if (!context.mounted) {
          return;
        } else {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
        }
      }
    }

    return ElevatedButton.icon(
      onPressed: () {
        onSignWithGoogle();
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
