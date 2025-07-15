import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/firebase_helper.dart';
import 'package:wcycle_bd/model/address_model.dart';

final apis = Apis();

class UserAddressDataProviderNotifier
    extends StateNotifier<List<AddressModel>> {
  UserAddressDataProviderNotifier() : super([]);

  Future<List<AddressModel>?> fetchData() async {
    final fsRef = await FirebaseHelper.fireStore
        .collection("userAddress")
        .where("userId", isEqualTo: FirebaseHelper.userId)
        .get();

    final addressData = fsRef.docs;

    final addressDataList = addressData
        .map((e) => AddressModel.fromJson(e.data(), addressID: e.id))
        .toList();

    state = addressDataList;
    return addressDataList;
  }
}

final userAddressDataProvider =
    StateNotifierProvider<UserAddressDataProviderNotifier, List<AddressModel>>(
        (ref) {
  return UserAddressDataProviderNotifier();
});
