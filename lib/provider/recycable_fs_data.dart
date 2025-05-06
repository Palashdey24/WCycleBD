import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/data/model/remote/recycle_product_model.dart';

final apis = Apis();

class RecycleFsDataProviderNotifier
    extends StateNotifier<List<RecycleProductModel>> {
  RecycleFsDataProviderNotifier() : super([]);

  Future<List<RecycleProductModel>?> fetchData() async {
    final fsRef =
        await FirebaseFirestore.instance.collection('recycleProduct').get();

    final productData = fsRef.docs;

    final productDataList = productData
        .map((e) => RecycleProductModel.fromJson(e.data(), e.id))
        .toList();

    state = productDataList;
    return productDataList;
  }
}

final recycleFsDataProvider = StateNotifierProvider<
    RecycleFsDataProviderNotifier, List<RecycleProductModel>>((ref) {
  return RecycleFsDataProviderNotifier();
});
