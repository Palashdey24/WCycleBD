import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/helper/firebase_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/pages/add/reuse/firebase_dropdown_helper.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/division_dropdown.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/form_text_outlined.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/time_date_collector.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/upload_image.dart';

class AddEventsItems extends StatelessWidget {
  const AddEventsItems({super.key});

  String? vaildWard(String? value) {
    if (value == null ||
        value.trim().isEmpty ||
        int.tryParse(value) == null ||
        int.tryParse(value)! < 1) {
      return "Please add A ward Number only like 3 and more than 0";
    }
    return null;
  }

  String? vaildetForms(String? value, String? formName, String errorMsg) {
    if (value == null ||
        value.trim().isEmpty ||
        value.trim().length < 3 ||
        value.trim() == "") {
      return "Please add A valid $errorMsg";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    late String eventTittle;
    late String eventDescription;

    late String ltAddress;
    late String ltDivision;
    late String ltVillMet;
    late String ltThana;
    late String ltWard;

    const int eventInterest = 0;
    String? impactLevel;
    String? eventDate;
    String? eventTime;

    final formKey = GlobalKey<FormState>();
    String? ltImage;
    String userID = FirebaseHelper.firebaseAuth.currentUser?.uid ?? "null";

    void onSave() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        //Check upload image and level are null or added
        if (ltImage == null || eventDate == null || eventTime == null) {
          DialogsHelper.showMessage(context,
              "Please check you may not upload Image/ Select Time / Date");
          return;
        } else {
          //Sent Littered data by Map to FirebaseHelper class where the function upload the data
          final eventsData =
              FirebaseHelper.fireStore.collection("events").doc();

          final upData = FirebaseHelper.upFirestoreDataWithID(
            {
              "userId": FirebaseHelper.firebaseAuth.currentUser!.uid,
              "createTimeStamp": DateTime.now(),
              "litteredAddress": ltAddress,
              "litteredVillMet": ltVillMet,
              "litteredThana": ltThana,
              "litteredDivision": ltDivision,
              "litteredImpactLevel": impactLevel,
              "litteredWard": ltWard,
              "ltSrc": ltImage,
              "eventsId": eventsData.id,
              "eventsTittle": eventTittle,
              "eventsDescription": eventDescription,
              "eventsInterested": eventInterest,
              "eventsDate": eventDate,
              "eventsTime": eventTime,
              "eventsOnline": true,
            },
            context,
            eventsData,
          );

          //Check the data successfully Up or Not
          formKey.currentState!.reset();

          DialogsHelper.showMessage(context, "Data Added Successfully");
        }
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Card(
        elevation: 10,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.orange, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(45))),
        color: Colors.blueGrey,
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  const Gap(largeGap),
                  UploadImage(
                    storageRef: "Events",
                    downloadUriFn: (uri) => ltImage = uri,
                  ),
                  const Gap(csGap),
                  FormTextOutlined(
                      iconData: FontAwesomeIcons.recycle,
                      fieldlabel: "Events Tittle",
                      fieldHint: "Please add event Tittle like we save tree",
                      fieldType: TextInputType.text,
                      vaildator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.trim().length < 3) {
                          return "Please add A event Tittle";
                        }
                        eventTittle = value;
                        return null;
                      }),
                  const Gap(csGap + 20),
                  FormTextOutlined(
                    iconData: FontAwesomeIcons.recycle,
                    fieldlabel: "Address",
                    fieldHint: "Please add Littered Spot Address",
                    fieldType: TextInputType.text,
                    maxLen: 72,
                    onSave: (value) => ltAddress = value,
                    vaildator: (value) =>
                        vaildetForms(value, "Address", "Address"),
                  ),
                  const Gap(csGap + 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DivisionDropdown(
                          onDropdownFn: (value) {
                            ltDivision = value;
                          },
                          formFieldValidator: (value) =>
                              vaildetForms(value, "Division", "Division"),
                          dropLevel: "Division",
                          dropHint: "select Division",
                          onSaved: (p0) => ltDivision = p0!,
                        ),
                      ),
                      Expanded(
                        child: FirebaseDropdownHelper(
                          onDropdownFn: (value) {
                            impactLevel = value;
                          },
                          dropHint: "Impact Level",
                          dropLevel: "Impact Level",
                          fsCollection: "imapctLevel",
                          fsField: "level",
                        ),
                      ),
                    ],
                  ),
                  const Gap(largeGap),
                  Row(
                    children: [
                      Expanded(
                        child: FormTextOutlined(
                          iconData: FontAwesomeIcons.recycle,
                          fieldlabel: "Village/Metro",
                          fieldHint: "Please add Village or Metro name",
                          fieldType: TextInputType.text,
                          maxLen: 18,
                          onSave: (value) => ltVillMet = value,
                          vaildator: (value) =>
                              vaildetForms(value, "Village", "Village"),
                        ),
                      ),
                      const Gap(csGap),
                      Expanded(
                        child: FormTextOutlined(
                            iconData: FontAwesomeIcons.recycle,
                            fieldlabel: "Thana",
                            fieldHint: "Please add Thana",
                            fieldType: TextInputType.text,
                            maxLen: 18,
                            onSave: (value) => ltThana = value,
                            vaildator: (value) =>
                                vaildetForms(value, "Thana", "Thana")),
                      ),
                    ],
                  ),
                  const Gap(csGap),
                  FormTextOutlined(
                      iconData: FontAwesomeIcons.recycle,
                      fieldlabel: "Ward",
                      fieldHint: "Please add a Ward",
                      fieldType: TextInputType.number,
                      onSave: (value) => ltWard = value,
                      vaildator: (value) => vaildWard(value)),
                  const Gap(csGap + 20),
                  FormTextOutlined(
                      iconData: FontAwesomeIcons.prescriptionBottleMedical,
                      fieldlabel: "Descriptions",
                      fieldHint: "Please add Descriptions",
                      fieldType: TextInputType.text,
                      maxLen: 256,
                      maxLines: 7,
                      vaildator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.trim().length < 3) {
                          return "Please add A Descriptions";
                        }
                        eventDescription = value;
                        return null;
                      }),
                  const Gap(csGap + 20),
                  TimeDateCollector(
                    onSelDate: (date) {
                      eventDate = date;
                    },
                    onSelTime: (time) {
                      eventTime = time;
                    },
                  ),
                  const Gap(largeGap),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () => formKey.currentState!.reset(),
                          icon: const Icon(Icons.refresh),
                          label: const Text("Reset")),
                      const Spacer(),
                      ElevatedButton.icon(
                          onPressed: onSave,
                          icon: const Icon(Icons.data_saver_on_rounded),
                          label: const Text("Save")),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
