import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/model/users.dart';

final apis = Apis();

class CurrentUserdataProviderNotifier extends StateNotifier<Users> {
  CurrentUserdataProviderNotifier()
      : super(Users(
            phoneNumber: "",
            gender: "",
            imgUri: "",
            userName: "",
            birthDate: "",
            email: "",
            userStatus: "",
            individual: true));

  Future<void> intiValue(BuildContext context, String userId) async {
    final fsRef = apis.fireStore.collection('users').doc(userId);

/*    final userDatas = await fsRef.get();

    var data = userDatas.data();
    Users users;
    if (data != null) {
      users = Users.fromJson(data);
      state = users;
    }*/

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
        if (!context.mounted) return;
        DialogsHelper.showMessage(context, "Listen Failed: $error");
      },
    );
  }
}

final currentUserdataProvider =
    StateNotifierProvider<CurrentUserdataProviderNotifier, Users>((ref) {
  return CurrentUserdataProviderNotifier();
});
