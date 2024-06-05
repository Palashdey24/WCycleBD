import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/widgets/card_text_fields.dart';
import 'package:wcycle_bd/widgets/form_text_texts.dart';

class RegForm extends StatefulWidget {
  const RegForm({super.key});

  @override
  State<RegForm> createState() => _RegFormState();
}

class _RegFormState extends State<RegForm> {
  String? userEmailTxt;

  String? userPassword;

  int ? userNumber;



  final _formKeyReg = GlobalKey<FormState>();

  void saveFn() {
    _formKeyReg.currentState!.validate();
    if (_formKeyReg.currentState!.validate()) {
      _formKeyReg.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyReg,
      child: Column(
        children: [
          CardTextFields(cardWidegts: FormTextTexts(
            txtInType: TextInputType.emailAddress,
            atCorrect: false,
            enSuggest: false,
            labelTxt: "Full Name",
            hint: "Please enter your Name",
            icons: Icons.text_rotation_angleup_rounded,
            iconCol: Colors.blueGrey,
            onSave: (value) => userEmailTxt=value,
            vaildator: (value) {
              if(value ==null || value.trim().isEmpty  || value.trim().length<4 ||                                     !value.trim().contains("@") ||
                  !value.trim().contains("."))
              {
                return "Please add A Valid Email Address which contains @ and .";
              }
              return null;
            },
          ),),
          CardTextFields(
            cardWidegts: FormTextTexts(
                txtInType: TextInputType.text,
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
                  return null;
                },
                obscure: false),
          ),


          CardTextFields(
              cardWidegts: FormTextTexts(
                txtInType: TextInputType.number,
                atCorrect: false,
                enSuggest: false,
                maxLen: 11,
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
                  userPassword = value;
                  return null;
                },
                onSave: (value) {
                  userPassword = value;
                },
              )),
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
              atCorrect: false,
              enSuggest: false,
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
              onSave: (value) {
              },
            ),
          ),



          CardTextFields(
            cardWidegts: FormTextTexts(
                txtInType: TextInputType.text,
                atCorrect: false,
                enSuggest: false,
                labelTxt: "BirthDate",
                hint: "Please enter a valid email",
                icons: Icons.email,
                iconCol: Colors.blueGrey,
                onSave: (value) => userEmailTxt = value,
                vaildator: (value) {
                  return null;
                },
                obscure: false),
          ),
          CardTextFields(
              cardWidegts: FormTextTexts(
                txtInType: TextInputType.visiblePassword,
                atCorrect: false,
                enSuggest: false,
                labelTxt: "Gender",
                hint: "Please enter at last 8 char Password",
                icons: Icons.password_rounded,
                iconCol: Colors.blueGrey,
                vaildator: (value) {
                  return null;
                },
                obscure: true,
                onSave: (value) {
                },
              )),
          const Gap(10),
          ElevatedButton(onPressed: saveFn, child: const Text("Save")),


        ],
      ),
    );
  }
}
