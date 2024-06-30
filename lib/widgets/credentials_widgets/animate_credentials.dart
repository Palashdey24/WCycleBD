import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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

    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 70,
            child: Icon(
              Icons.people,
              size: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedCrossFade(
                firstChild: const SigninForm(),
                secondChild: const RegForm(),
                crossFadeState: isSignForms
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(seconds: 1)),
          ),
          const Gap(10),
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
      ),
    );
  }
}
