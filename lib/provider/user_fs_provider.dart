import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/model/users.dart';

final apis = Apis();

class UserFsProviderNotifier extends StateNotifier<Users> {
  UserFsProviderNotifier()
      : super(Users(
            phoneNumber: "",
            gender: "",
            imgUri: "",
            userName: "",
            birthDate: "",
            email: "",
            userStatus: "",
            individual: true));

  void intiValue(BuildContext context, String userId) {
    final fsRef = apis.fireStore.collection('users').doc(userId);

    fsRef.snapshots().listen(
      (event) {
        //print("current data: ${event.data()!}");

        var data = event.data();
        Users users = Users.fromJson(data!);
        state = users;
      },
      onError: (error) {
        if (!context.mounted) return;
        DialogsHelper.showMessage(context, "Listen Failed: $error");
      },
    );
  }
}

final userFSProvider =
    StateNotifierProvider<UserFsProviderNotifier, Users>((ref) {
  return UserFsProviderNotifier();
});
