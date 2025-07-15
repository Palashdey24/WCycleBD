import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/helper/firebase_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/littered_model.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/form_text_outlined.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/time_date_collector.dart';

class CreateEventsItem extends StatelessWidget {
  const CreateEventsItem({super.key, required this.litteredModel});
  final LitteredModel litteredModel;

  static String? checkVaild(
      {required BuildContext context,
      String? value,
      required String failurMsg}) {
    if (value == null || value.trim().isEmpty || value.trim().length < 3) {
      return failurMsg;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    late String eventTittle;
    late String eventDescription;
    const int eventInterest = 0;
    String? eventDate;
    String? eventTime;

    final LitteredModel(
      :litteredAddress,
      :ltSrc,
      :litteredDivision,
      :litteredThana,
      :litteredTittle,
      :litteredImpactLevel,
      :litteredVillMet,
      :litteredWard
    ) = litteredModel;

    final formKey = GlobalKey<FormState>();
    String ltImage = ltSrc;

    late final String ltId;
    void getLitterId() async {
      final docRef = await FirebaseFirestore.instance
          .collection("litteredSpot")
          .where("ltSrc", isEqualTo: ltSrc)
          .get();

      ltId = docRef.docs[0].reference.id;
    }

    void onSave() {
      getLitterId();
      if (formKey.currentState!.validate()) {
        //Check upload image and level are null or added
        if (eventDate == null || eventTime == null) {
          DialogsHelper.showMessage(context,
              "Please check you may not upload Image/ Select Time / Date");
          return;
        } else {
          final eventCollection =
              FirebaseHelper.fireStore.collection("events").doc();
          //Sent Littered data by Map to FirebaseHelper class where the function upload the data
          FirebaseHelper.upFirestoreDataWithID({
            "userId": FirebaseHelper.firebaseAuth.currentUser!.uid,
            "createTimeStamp": DateTime.now(),
            "litteredAddress": litteredAddress,
            "litteredVillMet": litteredVillMet,
            "litteredThana": litteredThana,
            "litteredDivision": litteredDivision,
            "litteredImpactLevel": litteredImpactLevel,
            "litteredWard": litteredWard,
            "ltSrc": ltImage,
            "eventsId": eventCollection.id,
            "eventsTittle": eventTittle,
            "eventsDescription": eventDescription,
            "eventsInterested": eventInterest,
            "eventsDate": eventDate,
            "eventsTime": eventTime,
            "eventsOnline": true,
          }, context, eventCollection)
              .whenComplete(
            () {
              formKey.currentState!.reset();
              FirebaseFirestore.instance
                  .collection("litteredSpot")
                  .doc(ltId)
                  .update({"productOnline": false}).then(
                (value) {
                  if (!context.mounted) return;
                  DialogsHelper.showMessage(context, "Data Added Successfully");
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                },
              );
            },
          );

          //Check the data successfully Up or Not
        }
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Card(
            elevation: 10,
            shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.orange, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(45))),
            color: Colors.blueGrey,
            child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(largeGap),
                      ClipOval(
                          child: Image.network(
                        litteredModel.ltSrc,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )),
                      const Gap(csGap),
                      FormTextOutlined(
                          iconData: FontAwesomeIcons.recycle,
                          fieldlabel: "Events Tittle",
                          fieldHint:
                              "Please add event Tittle like we save tree",
                          fieldType: TextInputType.text,
                          isEnable: false,
                          intValue: litteredModel.litteredTittle,
                          vaildator: (value) {
                            checkVaild(
                                context: context,
                                value: value,
                                failurMsg: "Please add A event Tittle");
                            eventTittle = value!;
                            return null;
                          }),
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
                        axisDirection: Axis.vertical,
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
        ),
      ),
    );
  }
}
