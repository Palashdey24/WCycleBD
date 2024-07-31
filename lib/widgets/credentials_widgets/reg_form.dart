import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/widgets/card_text_fields.dart';
import 'package:wcycle_bd/widgets/credentials_widgets/organization_docs.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/dropdown_widgets.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/essential_reg_form.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/time_date_collector.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/upload_image.dart';
import 'package:wcycle_bd/widgets/credentials_widgets/user_type.dart';

final genders = ["Male", "Female", "Other"];

final userType = ["Individual", "Organization"];
final api = Apis();

final dialogHelpers = DialogsHelper();

class RegForm extends StatefulWidget {
  const RegForm({super.key});

  @override
  State<RegForm> createState() => _RegFormState();
}

class _RegFormState extends State<RegForm> {
  final formKeyReg = GlobalKey<FormState>();

  String? userEmailTxt;

  String? userPassword;

  String? fullName;

  String? phoneNumber;

  String? birthDate;

  String? gender;
  String? userImg;
  bool individualAct = true;

  void addData() async {
    DialogsHelper().showProgressBar(context);

    try {
      await Apis().firebaseAuth.createUserWithEmailAndPassword(
          email: userEmailTxt!, password: userPassword!);

      api.setUser({
        "userName": fullName,
        "email": userEmailTxt,
        "phoneNumber": phoneNumber,
        "birthDate": birthDate ?? "N/A",
        "gender": gender ?? "N/A",
        "img_uri": userImg,
        "online": false,
        "user_type": individualAct,
        "userStatus": "Approved",
      }, individualAct ? "users" : "organizations");

      if (!mounted) return;
      Navigator.pop(context);
    } on FirebaseAuthException catch (error) {
      if (!mounted) return;
      Navigator.pop(context);
      DialogsHelper().removeMessage(context);
      DialogsHelper()
          .showMessage(context, error.message ?? "Authentication Failed");
    }
  }

  void saveFn() async {
    if (formKeyReg.currentState!.validate()) {
      formKeyReg.currentState!.save();

      if (!individualAct || userImg != null) {
        addData();
        return;
      }

      if (userImg != null || birthDate != null || gender != null) {
        addData();
        return;
      } else {
        dialogHelpers.removeMessage(context);
        dialogHelpers.showMessage(context,
            "Please check are you upload Image or Add birthdate or Gender");
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeyReg,
      child: Column(
        children: [
          Row(
            children: [
              for (var users in userType)
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        individualAct = !individualAct;
                      });
                    },
                    child: users == userType[0]
                        ? UserType(
                            animatedColors:
                                individualAct ? Colors.orange : Colors.white,
                            userText: users,
                          )
                        : UserType(
                            animatedColors:
                                individualAct ? Colors.white : Colors.orange,
                            userText: users,
                          ),
                  ),
                )
            ],
          ),
          const Gap(largeGap),
          UploadImage(
              downloadUriFn: (uri) => userImg = uri, storageRef: "users"),
          const Gap(csGap),
          EssentialRegForm(
              onSaveName: (value) => fullName = value,
              onSaveEmail: (value) => userEmailTxt = value,
              onSaveNumber: (value) => phoneNumber = value,
              onSavePassword: (value) => userPassword = value),
          const Gap(normalGap),
          AnimatedSlide(
            duration: const Duration(milliseconds: 500),
            offset: individualAct ? const Offset(0, 0) : const Offset(1, 0),
            child: Visibility(
              visible: individualAct,
              child: Column(
                children: [
                  CardTextFields(
                    cardWidegts: DropdownWidgets(
                        labelTxtColor: Colors.orange,
                        formFieldValidator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim() == "") {
                            return "Please select Gender";
                          }
                          gender = value;
                          return null;
                        },
                        dropLevel: "Gender",
                        dropHint: "Please select a Gender",
                        dropDownList: genders),
                  ),
                  CardTextFields(
                      cardWidegts: TimeDateCollector(
                    firstDates: DateTime(1950),
                    lastDates: DateTime.now(),
                    lableColor: Colors.black,
                    onSelDate: (date) => birthDate = date,
                    timeTracker: false,
                  )),
                ],
              ),
            ),
          ),
          AnimatedSlide(
              curve: Easing.linear,
              duration: const Duration(seconds: 1),
              offset: !individualAct ? const Offset(0, 0) : const Offset(1, 0),
              child: Visibility(
                  visible: !individualAct, child: const OrganizationDocs())),
          const Gap(10),
          ElevatedButton(onPressed: saveFn, child: const Text("Save")),
        ],
      ),
    );
  }
}
