import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/data/model/remote/recycle_product_model.dart';

class RecycleRecommendProviderNotifier
    extends StateNotifier<List<RecycleProductModel>> {
  RecycleRecommendProviderNotifier() : super([]);

  void recommendate(String productName) async {
    final recycleQuery = await FirebaseFirestore.instance
        .collection("recycleProduct")
        .where('productOnline', isEqualTo: false)
        .where("productName", isEqualTo: productName)
        .get();
    final recycleData = recycleQuery.docs;
    //Add data to model list one after one
    state = recycleData
        .map(
          (e) => RecycleProductModel.fromJson(e.data(), e.id),
        )
        .toList();
  }
}

final recyclerecommendProvider = StateNotifierProvider<
    RecycleRecommendProviderNotifier, List<RecycleProductModel>>(
  (ref) {
    return RecycleRecommendProviderNotifier();
  },
);
