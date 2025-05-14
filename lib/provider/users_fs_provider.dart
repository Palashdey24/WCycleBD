import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/helper/firebase_helper.dart';
import 'package:wcycle_bd/model/users.dart';

class UsersFsProviderNotifier extends StateNotifier<List<Users>> {
  UsersFsProviderNotifier() : super([]);

  Future<bool?> loadUsersAllData() async {
    final firebaseUri =
        await FirebaseHelper.fireStore.collection('users').get();

    final userData = firebaseUri.docs;

    state =
        userData.map((e) => Users.fromJson(e.data(), userId: e.id)).toList();

    return true;
  }
}

final usersFsProviders =
    StateNotifierProvider<UsersFsProviderNotifier, List<Users>>((ref) {
  return UsersFsProviderNotifier();
});
