import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/helper/firebase_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/users.dart';
import 'package:wcycle_bd/screen/splash_screen.dart';
import 'package:wcycle_bd/utilts/colors.dart';
import 'package:wcycle_bd/widgets/card_text_fields.dart';
import 'package:wcycle_bd/widgets/credentials_widgets/organization_docs.dart';
import 'package:wcycle_bd/widgets/credentials_widgets/user_type.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/dropdown_widgets.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/essential_reg_form.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/time_date_collector.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/upload_image.dart';

final genders = ["Male", "Female", "Other"];

final userType = ["Individual", "Organization"];
final api = Apis();

class RegForm extends StatefulWidget {
  const RegForm({super.key});

  @override
  State<RegForm> createState() => _RegFormState();
}

class _RegFormState extends State<RegForm> with TickerProviderStateMixin {
  final formKeyReg = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  String? userEmailTxt;

  String? userPassword;

  String? fullName;

  String? phoneNumber;

  String? birthDate;

  String? gender;
  String? userImg;
  String? docName;
  String? docDownloadUri;
  File? docFile;
  bool individualAct = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween(end: 1.0, begin: 0.0).animate(_animationController)
      ..addStatusListener(
        (status) {
          setState(() {});
        },
      )
      ..addStatusListener(
        (status) {
          _status = status;
        },
      );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  void addData() async {
    DialogsHelper.showProgressBar(context);

    try {
      if (!individualAct) {
        docDownloadUri = await FirebaseHelper.uploadFile(
                context, "organizer", "pdf", docName!, docFile!, false)
            .catchError((error) {
          if (!mounted) return null;
          Navigator.pop(context);
          DialogsHelper.showMessage(
              context, error.message ?? "Authentication Failed");
          return null;
        });
      }
      await Apis()
          .firebaseAuth
          .createUserWithEmailAndPassword(
              email: userEmailTxt!, password: userPassword!)
          .then(
        (value) {
          if (value.user != null) {
            api.setUser(
                Users(
                        phoneNumber: phoneNumber ?? "N?A",
                        gender: gender ?? "N/A",
                        imgUri: userImg!,
                        userName: fullName!,
                        birthDate: birthDate ?? "N/A",
                        email: userEmailTxt!,
                        individual: individualAct,
                        userStatus: "Under Review",
                        doc: docDownloadUri)
                    .toJson(),
                "users");

            if (!mounted) return;
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ));
          }
        },
      );
    } on FirebaseAuthException catch (error) {
      if (!mounted) return;
      Navigator.pop(context);
      DialogsHelper.showMessage(
          context, error.message ?? "Authentication Failed");
    }
  }

  void saveFn() async {
    if (formKeyReg.currentState!.validate()) {
      formKeyReg.currentState!.save();
      if (!individualAct && userImg != null && docName != null) {
        addData();
        return;
      } else if (userImg != null && birthDate != null && gender != null) {
        addData();
        return;
      } else {
        DialogsHelper.showMessage(
            context, "Upload Image or Add birthdate or Gender or Doc File");
        return;
      }
    }
  }

  void onAnimation() {
    if (_status == AnimationStatus.dismissed) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeyReg,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 8.0, right: 8),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.identity()
                    ..setEntry(2, 1, 0.0015)
                    ..rotateY(pi * 2 * _animation.value),
                  child: child,
                );
              },
              child: Card(
                color: kDefaultColor,
                child: Column(
                  children: [
                    const Gap(largeGap + 20),
                    EssentialRegForm(
                        onSaveName: (value) => fullName = value,
                        onSaveEmail: (value) => userEmailTxt = value,
                        onSaveNumber: (value) => phoneNumber = value,
                        onSavePassword: (value) => userPassword = value),
                    const Gap(normalGap),
                    Visibility(
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
                    Visibility(
                        visible: !individualAct,
                        child: OrganizationDocs(
                          onDocs: (name, file) {
                            docName = name;
                            docFile = file;
                          },
                        )),
                    const Gap(10),
                    ElevatedButton(
                        onPressed: saveFn, child: const Text("Save")),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: SizedBox(
              width: api.deviceWidth(context),
              child: UploadImage(
                  radius: 50,
                  downloadUriFn: (uri) => userImg = uri,
                  storageRef: "users"),
            ),
          ),
          for (var users in userType)
            Positioned(
              top: userType.indexOf(users) == 0 ? 0 : 5,
              right: userType.indexOf(users) != 0 ? 0 : null,
              child: UserType(
                individual: userType.indexOf(users) == 0
                    ? !individualAct
                    : individualAct,
                onTap: () {
                  setState(() {
                    if (userType.indexOf(users) == 0) {
                      individualAct = true;
                    } else {
                      individualAct = false;
                    }
                    onAnimation();
                  });
                },
                rotateY:
                    userType.indexOf(users) != 0 ? (-1 + 120 * pi / 180) : null,
                quarterTurns: userType.indexOf(users) != 0 ? 2 : null,
                userText: users,
              ),
            ),
        ],
      ),
    );
  }
}
