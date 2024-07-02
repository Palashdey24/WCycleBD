import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/widgets/card_text_fields.dart';
import 'package:wcycle_bd/widgets/form_text_texts.dart';

class RegForm extends StatefulWidget {
  const RegForm({super.key});

  @override
  State<RegForm> createState() => _RegFormState();
}

class _RegFormState extends State<RegForm> {
  final _formKeyReg = GlobalKey<FormState>();

  String? userEmailTxt;
  String? userPassword;
  int? userNumber;
  String? fullName;
  String? phoneNumber;
  String? birthDate;
  String? gender;

  void saveFn() async {
    FocusScope.of(context).unfocus();
    _formKeyReg.currentState!.validate();
    if (_formKeyReg.currentState!.validate()) {
      DialogsHelper().showProgressBar(context);
      _formKeyReg.currentState!.save();

      try {
        final credentials = await Apis()
            .firebaseAuth
            .createUserWithEmailAndPassword(
                email: userEmailTxt!, password: userPassword!);

        Apis().setUser({
          "userName": fullName,
          "email": userEmailTxt,
          "phoneNumber": phoneNumber,
          "birthDate": birthDate,
          "gender": gender,
          "img_uri": "N/A",
        });

        if (!context.mounted) return;
        Navigator.pop(context);
      } on FirebaseAuthException catch (error) {
        if (!context.mounted) return;
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
      key: _formKeyReg,
      child: Column(
        children: [
          CardTextFields(
            cardWidegts: FormTextTexts(
              txtInType: TextInputType.text,
              labelTxt: "Full Name",
              hint: "Please enter your Name",
              icons: Icons.text_rotation_angleup_rounded,
              iconCol: Colors.blueGrey,
              onSave: (value) {
                fullName = value;
              },
              vaildator: (value) {
                if (value == null ||
                    value.trim().isEmpty ||
                    value.trim().length < 4) {
                  return "Please add Full Name";
                }
                return null;
              },
            ),
          ),
          CardTextFields(
            cardWidegts: FormTextTexts(
                txtInType: TextInputType.emailAddress,
                atCorrect: false,
                enSuggest: false,
                labelTxt: "Email",
                hint: "Please enter a valid email",
                icons: Icons.email,
                iconCol: Colors.blueGrey,
                onSave: (value) => userEmailTxt = value,
                vaildator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.trim().length < 4) {
                    return "Please add A Valid Email Address which contains @ and .";
                  }
                  userEmailTxt = value;
                  return null;
                },
                obscure: false),
          ),
          CardTextFields(
              cardWidegts: FormTextTexts(
            txtInType: TextInputType.number,
            maxLen: 13,
            intial: "880",
            labelTxt: "Phone Number",
            hint: "Please enter Phone Number number",
            icons: Icons.phone_android,
            iconCol: Colors.blueGrey,
            vaildator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  value.trim().length < 11) {
                return "Please enter valid 11 digit number";
              }
              return null;
            },
            onSave: (value) {
              phoneNumber = value;
            },
          )),
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
              userPassword = value;
              return null;
            },
            obscure: true,
            onSave: (value) {
              userPassword = value;
            },
          )),
          CardTextFields(
            cardWidegts: FormTextTexts(
              txtInType: TextInputType.visiblePassword,
              labelTxt: "Retype Password",
              hint: "Please enter at last 8 char Password",
              icons: Icons.password_rounded,
              iconCol: Colors.blueGrey,
              vaildator: (value) {
                if (value != userPassword) {
                  return "Password Not Match";
                }
                return null;
              },
              obscure: true,
              onSave: (value) {},
            ),
          ),
          CardTextFields(
            cardWidegts: FormTextTexts(
                txtInType: TextInputType.text,
                labelTxt: "BirthDate",
                hint: "Please enter BirthDate",
                icons: Icons.email,
                iconCol: Colors.blueGrey,
                onSave: (value) {
                  birthDate = value == "" ? "N/A" : value;
                },
                vaildator: (value) {
                  return null;
                },
                obscure: false),
          ),
          CardTextFields(
              cardWidegts: FormTextTexts(
            txtInType: TextInputType.visiblePassword,
            labelTxt: "Gender",
            hint: "Please enter at last 8 char Password",
            icons: Icons.password_rounded,
            iconCol: Colors.blueGrey,
            vaildator: (value) {
              return null;
            },
            obscure: true,
            onSave: (value) {
              gender = value == "" ? "N/A" : value;
            },
          )),
          const Gap(10),
          ElevatedButton(onPressed: saveFn, child: const Text("Save")),
        ],
      ),
    );
  }
}
