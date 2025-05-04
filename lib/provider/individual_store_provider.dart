import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/model/store_model.dart';

class IndividualStoreProviderNotifier extends StateNotifier<StoreModel> {
  IndividualStoreProviderNotifier()
      : super(StoreModel(
            rating: 0,
            totalRated: 0,
            phoneNumber: "N/A",
            storeAddress: "N?A",
            locations: Locations.fromJson({}),
            storeName: "N/A",
            docUri: "N?A",
            id: "N/A",
            logoUri: "N/A",
            storeStatus: "N/A",
            email: "N/A",
            storeBin: "N/A"));

  void shopData(BuildContext context, String shopId) {
    final fsRef = FirebaseFirestore.instance.collection('store').doc(shopId);

    fsRef.snapshots().listen(
      (event) {
        var data = event.data();
        StoreModel shopModel = StoreModel.fromJson(data!);
        state = shopModel;
      },
      onError: (error) {
        if (!context.mounted) return;
        DialogsHelper.showMessage(context, "Listen Failed: $error");
      },
    );
  }
}

final individualStoreProvider =
    StateNotifierProvider<IndividualStoreProviderNotifier, StoreModel>((ref) {
  return IndividualStoreProviderNotifier();
});
