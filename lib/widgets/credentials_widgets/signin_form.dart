import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/widgets/card_text_fields.dart';
import 'package:wcycle_bd/widgets/form_text_texts.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _formKeyLog = GlobalKey<FormState>();

  String? emailTxt;

  String? password;

  void saveFn() async {
    FocusScope.of(context).unfocus();
    _formKeyLog.currentState!.validate();
    if (_formKeyLog.currentState!.validate()) {
      DialogsHelper().showProgressBar(context);
      _formKeyLog.currentState!.save();

      try {
        final credentials = await Apis()
            .firebaseAuth
            .signInWithEmailAndPassword(email: emailTxt!, password: password!);
        Navigator.pop(context);
      } on FirebaseAuthException catch (error) {
        if (!context.mounted) {
          return;
        }
        Navigator.pop(context);
        DialogsHelper().removeMessage(context);
        DialogsHelper()
            .showMessage(context, error.message ?? "Authentication Failed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyLog,
      child: Column(
        children: [
          CardTextFields(
            cardWidegts: FormTextTexts(
              txtInType: TextInputType.emailAddress,
              labelTxt: "Email",
              hint: "Please enter a valid email",
              icons: Icons.email,
              iconCol: Colors.blueGrey,
              onSave: (value) => emailTxt = value,
              vaildator: (value) {
                if (value == null ||
                    value.trim().isEmpty ||
                    value.trim().length < 4 ||
                    !value.trim().contains("@") ||
                    !value.trim().contains(".")) {
                  return "Please add A Valid Email Address which contains @ and .";
                }
                return null;
              },
            ),
          ),
          const Gap(10),
          CardTextFields(
              cardWidegts: FormTextTexts(
            txtInType: TextInputType.visiblePassword,
            labelTxt: "Password",
            hint: "Please enter at last 8 char Password",
            icons: Icons.password_rounded,
            iconCol: Colors.blueGrey,
            vaildator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  value.trim().length < 8) {
                return "Please add A Strong 8S char Pass";
              }
              return null;
            },
            obscure: true,
            onSave: (value) {
              password = value;
            },
          )),
          const Gap(10),
          ElevatedButton(onPressed: saveFn, child: const Text("Save")),
        ],
      ),
    );
  }
}
