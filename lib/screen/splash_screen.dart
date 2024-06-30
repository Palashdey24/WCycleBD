import 'package:flutter/material.dart';
import 'package:wcycle_bd/screen/credentials_screen.dart';
import 'package:wcycle_bd/screen/home_screen.dart';
import 'package:wcycle_bd/utilts/global_value.dart';
import 'package:wcycle_bd/widgets/loading_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firebaseAuth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 300,
            child: LoadingWidgets(),
          );
        }
        if (snapshot.hasData) {
          return const HomeScreen();
        }
        return const CredentialScreen();
      },
    );
  }
}
