import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wcycle_bd/screen/credentials_screen.dart';
import 'package:wcycle_bd/utilts/variable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final colorSch =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(207, 5, 23, 7));

_intilizeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _intilizeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: colorSch,
        primaryColor: kDefaultColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: const CredentialScreen(),
    );
  }
}
