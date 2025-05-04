import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/provider/user_fs_provider.dart';
import 'package:wcycle_bd/screen/credentials_screen.dart';
import 'package:wcycle_bd/screen/home_screen.dart';
import 'package:wcycle_bd/widgets/loading_widget.dart';

class AuthCheckScreen extends ConsumerWidget {
  const AuthCheckScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: Apis().firebaseAuth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 300,
            child: LoadingWidgets(),
          );
        }
        if (snapshot.hasData) {
          ref.read(userFSProvider.notifier).intiValue(
              context, FirebaseAuth.instance.currentUser!.uid.toString());
          return const HomeScreen();
        }
        return const CredentialScreen();
      },
    );
  }
}
