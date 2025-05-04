import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/model/store_model.dart';

class StoreFsDataProviderNotifier extends StateNotifier<List<StoreModel>> {
  StoreFsDataProviderNotifier() : super([]);

  void loadStoreAllData() async {
    final fsRef = await FirebaseFirestore.instance.collection('store').get();
    final storeData = fsRef.docs;

    final storeDataList =
        storeData.map((e) => StoreModel.fromJson(e.data())).toList();

    state = storeDataList;
  }
}

final storeFsDataProvider =
    StateNotifierProvider<StoreFsDataProviderNotifier, List<StoreModel>>((ref) {
  return StoreFsDataProviderNotifier();
});
