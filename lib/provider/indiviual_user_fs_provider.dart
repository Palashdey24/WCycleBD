import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/model/users.dart';

final apis = Apis();

class IndividualUserdataProviderNotifier extends StateNotifier<Users> {
  IndividualUserdataProviderNotifier()
      : super(Users(
            phoneNumber: "",
            gender: "",
            imgUri: "",
            userName: "",
            birthDate: "",
            email: "",
            userStatus: "",
            individual: true));

  Future<void> intiValue(String userId) async {
    final fsRef = apis.fireStore.collection('users').doc(userId);

    fsRef.snapshots().listen(
      (event) {
        //print("current data: ${event.data()!}");

        if (event.exists) {
          var data = event.data();
          Users users = Users.fromJson(data!);
          state = users;
        }
      },
      onError: (error) {
        log("Listen Failed: $error");
      },
    );
  }
}

final individualUserdataProvider =
    StateNotifierProvider<IndividualUserdataProviderNotifier, Users>((ref) {
  return IndividualUserdataProviderNotifier();
});
