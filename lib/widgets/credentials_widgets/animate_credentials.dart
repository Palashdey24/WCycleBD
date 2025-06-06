import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/widgets/credentials_widgets/credentials_signin_with_google.dart';
import 'package:wcycle_bd/widgets/credentials_widgets/reg_form.dart';
import 'package:wcycle_bd/widgets/credentials_widgets/signin_form.dart';

class AnimateCredentials extends StatefulWidget {
  const AnimateCredentials({super.key});

  @override
  State<AnimateCredentials> createState() => _AnimateCredentialsState();
}

class _AnimateCredentialsState extends State<AnimateCredentials> {
  var isSignForms = true;

  void changeCredential() {
    setState(() {
      isSignForms = !isSignForms;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Column(
      children: [
        AnimatedCrossFade(
            firstChild: const Center(child: SigninForm()),
            secondChild: const RegForm(),
            crossFadeState: isSignForms
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(seconds: 1)),
        const Gap(normalGap),
        TextButton(
            onPressed: changeCredential,
            child: Text(
              isSignForms
                  ? "Don't have a Account? Create A Account"
                  : "Already have Account? Please SignIn",
              style: theme.titleMedium!.copyWith(color: Colors.orangeAccent),
            )),
        Visibility(
            visible: isSignForms, child: const CredentialsSigninWithGoogle()),
      ],
    );
  }
}
