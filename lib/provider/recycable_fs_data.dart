import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/data/model/remote/recycle_product_model.dart';

final recycableFsDataProvider = Provider(
  (ref) async {
    final fsRef =
        await FirebaseFirestore.instance.collection('recycleProduct').get();
    final productData = fsRef.docs;

    final productDataList = productData
        .map((e) => RecycleProductModel.fromJson(e.data(), e.id))
        .toList();

    return productDataList;
  },
);
