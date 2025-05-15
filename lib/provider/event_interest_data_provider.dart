import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/model/event_interest_model.dart';

class InterestedUserProviderNotifier
    extends StateNotifier<EventInterestedModel> {
  InterestedUserProviderNotifier()
      : super(EventInterestedModel(
            eventsInterested: 0, eventsId: "", interestedUsers: []));

  Future<bool?> eventInterestUserData(String eventId) async {
    final fsRef = await FirebaseFirestore.instance
        .collection('events')
        .doc(eventId)
        .get()
        .then(
      (value) {
        state = EventInterestedModel.fromJson(value.data());

        return true;
      },
    ).onError(
      (error, stackTrace) {
        log("error: $error");
        state = EventInterestedModel(
            eventsId: eventId, eventsInterested: 0, interestedUsers: []);
        return false;
      },
    );

    return false;
  }
}

final eventInterestUserProvider =
    StateNotifierProvider<InterestedUserProviderNotifier, EventInterestedModel>(
        (ref) {
  return InterestedUserProviderNotifier();
});

/*final eventInterestUserFSProvider =
    Provider<Future<List<EventInterestedModel>>>((ref) async {
  final fsRef = await FirebaseFirestore.instance.collection('events').get();
  final interestedUserData = fsRef.docs;

  final interestedUserList = interestedUserData
      .map((e) => EventInterestedModel.fromJson(e.data()))
      .toList();

  return interestedUserList;
});*/
