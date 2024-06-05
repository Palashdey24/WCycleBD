import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/widgets/reg_form.dart';
import 'package:wcycle_bd/widgets/signin_form.dart';

class AnimateCredentials extends StatelessWidget {
  const AnimateCredentials({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    ValueNotifier<bool> isSignForms = ValueNotifier(true);

    void changeCredential() {
      isSignForms.value = !isSignForms.value;
    }

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
          ValueListenableBuilder(
            valueListenable: isSignForms,
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedCrossFade(
                    firstChild: const SigninForm(),
                    secondChild: const RegForm(),
                    crossFadeState: value
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(seconds: 1)),
              );
            },
          ),
          const Gap(10),
          TextButton(
              onPressed: changeCredential,
              child: Text(
                isSignForms.value
                    ? "Don't have a Account? Create A Account"
                    : "Already have Account? Please SignIn",
                style: theme.titleMedium!.copyWith(color: Colors.orangeAccent),
              )),
        ],
      ),
    );
  }
}
