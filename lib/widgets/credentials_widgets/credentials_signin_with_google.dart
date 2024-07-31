import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/screen/home_screen.dart';

final api = Apis();

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
    return await api.firebaseAuth.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    void onSignWithGoogle() {
      DialogsHelper().showProgressBar(context);
      //final googleSignIn = await signInWithGoogle();

      //This is for Sign by Google

      signInWithGoogle().then(
        (value) async {
          Navigator.pop(context);
          if ((await api.userExist())) {
            if (!context.mounted) return;
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ));
            return;
          } else {
            await api.createGoogleUser().then((onValue) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
              return;
            });
          }
        },
      );
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
