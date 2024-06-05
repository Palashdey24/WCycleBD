import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/screen/home_screen.dart';
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

  void saveFn() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
    _formKeyLog.currentState!.validate();
    if (_formKeyLog.currentState!.validate()) {
      _formKeyLog.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(emailTxt!),
        ),
      );
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
              atCorrect: false,
              enSuggest: false,
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
            atCorrect: false,
            enSuggest: false,
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
