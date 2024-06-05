import 'package:flutter/material.dart';
import 'package:wcycle_bd/path/signin_tri_path_left.dart';
import 'package:wcycle_bd/widgets/animate_credentials.dart';

class CredentialScreen extends StatelessWidget {
  const CredentialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scnHeight = MediaQuery.sizeOf(context).height;
    final scnWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: ClipPath(
              clipper: SignInTriPathLeft(),
              child: Container(
                width: scnWidth,
                height: scnHeight / 1.5,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: RotatedBox(
              quarterTurns: 2,
              child: ClipPath(
                clipper: SignInTriPathLeft(),
                child: Container(
                  width: scnWidth,
                  height: scnHeight / 1.5,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
          const Center(
              child: SingleChildScrollView(child: AnimateCredentials())),
        ],
      ),
    );
  }
}
