import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/helper/firebase_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/pages/add/add_littered_spot_items.dart';
import 'package:wcycle_bd/provider/event_interest_data_provider.dart';

class ButtonsWidgetEvents extends ConsumerWidget {
  const ButtonsWidgetEvents({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void eventInterestedFn(bool isOnInterested, String eventID) async {
      DialogsHelper.showProgressBar(context);
      final firebaseUri =
          FirebaseHelper.fireStore.collection('events').doc(eventID);
      if (!isOnInterested) {
        firebaseUri.update({
          'eventsInterested': FieldValue.increment(1),
          //* By this function we increase the user Data
          'interestedUsers': FieldValue.arrayUnion(
              [FirebaseHelper.firebaseAuth.currentUser!.uid])
        }).then(
          (value) {
            ref
                .read(eventInterestUserProvider.notifier)
                .eventInterestUserData(eventID);
            if (!context.mounted) return;
            DialogsHelper.showMessage(context, "Updated Interested");
            Navigator.pop(context);
          },
        );
      } else {
        firebaseUri.update({
          'eventsInterested': FieldValue.increment(-1),
          //* By this function we increase the user Data
          'interestedUsers': FieldValue.arrayRemove(
              [FirebaseHelper.firebaseAuth.currentUser!.uid])
        }).then(
          (value) {
            ref
                .read(eventInterestUserProvider.notifier)
                .eventInterestUserData(eventID);
            if (!context.mounted) return;
            DialogsHelper.showMessage(context, "Not Interested");
            Navigator.pop(context);
          },
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: normalGap,
        children: [
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              final eventInterested = ref.watch(eventInterestUserProvider);
              bool userOnInterested = false;
              if (eventInterested.interestedUsers != null) {
                userOnInterested = eventInterested.interestedUsers!
                    .contains(FirebaseHelper.firebaseAuth.currentUser!.uid);
              }
              return ElevatedButton(
                  onPressed: () => eventInterestedFn(
                      userOnInterested, eventInterested.eventsId!),
                  child:
                      Text(userOnInterested ? "Not Interested" : "Interested"));
            }),
          ),
          Expanded(
            child: ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddLitteredSpotItems(),
                    )),
                child: const Text("Donate")),
          ),
        ],
      ),
    );
  }
}
