import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/data/model/remote/recycle_product_model.dart';

class RecycableProviderNotifier extends StateNotifier<RecycleProductModel> {
  RecycableProviderNotifier()
      : super(RecycleProductModel(
            impactLevel: "",
            productImage: "",
            productName: "",
            productOnline: false,
            productPrice: 0,
            shopID: "",
            productID: "N/A"));

  void onChange(RecycleProductModel rcModel) {
    state = rcModel;
  }
}

final recycableProvider =
    StateNotifierProvider<RecycableProviderNotifier, RecycleProductModel>(
  (ref) {
    return RecycableProviderNotifier();
  },
);
