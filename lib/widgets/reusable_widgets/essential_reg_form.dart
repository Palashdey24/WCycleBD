import 'package:flutter/material.dart';
import 'package:wcycle_bd/widgets/card_text_fields.dart';
import 'package:wcycle_bd/widgets/form_text_texts.dart';

class EssentialRegForm extends StatelessWidget {
  const EssentialRegForm(
      {super.key,
      required this.onSaveName,
      required this.onSaveEmail,
      required this.onSaveNumber,
      required this.onSavePassword});

  final void Function(String value) onSaveName;
  final void Function(String value) onSaveEmail;
  final void Function(String value) onSaveNumber;
  final void Function(String value) onSavePassword;

  @override
  Widget build(BuildContext context) {
    late String userPassword;

    return Column(
      children: [
        CardTextFields(
          cardWidegts: FormTextTexts(
            txtInType: TextInputType.text,
            labelTxt: "Full Name",
            hint: "Please enter your Name",
            icons: Icons.text_rotation_angleup_rounded,
            iconCol: Colors.blueGrey,
            onSave: onSaveName,
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
              onSave: onSaveEmail,
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
          onSave: onSaveNumber,
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
          onSave: (value) {},
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
      ],
    );
  }
}
