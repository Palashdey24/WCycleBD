import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/data/model/local/cart_database.dart';
import 'package:wcycle_bd/helper/firebase_helper.dart';
import 'package:wcycle_bd/model/local_cart_model.dart';
import 'package:wcycle_bd/provider/recycable_fs_data.dart';
import 'package:wcycle_bd/provider/store_fs_data.dart';

class LocalCartIntiProviderNotifier
    extends StateNotifier<List<LocalCartModel>> {
  LocalCartIntiProviderNotifier() : super([]);

  Future<List<LocalCartModel>?> loadIntiCartData() async {
    final db = await CartDatabase.getDatabase();
    final cartDatabase = await db.query("carts");

    if (cartDatabase.isEmpty) {
      return null;
    }
    final cartData = cartDatabase.map((e) {
      return LocalCartModel(
          id: e['id'] as String,
          userID: e['userID'] as String,
          productId: e['productId'] as String,
          storeId: e['storeId'] as String,
          quantity: e['quantity'] as int);
    }).toList();

    final cartDataById = cartData.where(
      (element) {
        return element.userID == FirebaseHelper.userId;
      },
    ).toList();
    state = cartDataById.reversed.toList();
    return cartData;
  }
}

final localCartIntiProvider =
    StateNotifierProvider<LocalCartIntiProviderNotifier, List<LocalCartModel>>(
        (ref) {
  return LocalCartIntiProviderNotifier();
});

final localCartProvider = Provider<List<LocalCartModel>>((ref) {
  ref.watch(localCartIntiProvider.notifier).loadIntiCartData();
  final localCart = ref.watch(localCartIntiProvider);
  final storeData = ref.watch(storeFsDataProvider);
  final recycleProduct = ref.watch(recycleFsDataProvider);

  final localCartData = localCart.map((e) {
    final storeDatastore = storeData.firstWhere(
      (element) {
        return element.id == e.storeId;
      },
    );

    final recycleProductData = recycleProduct.firstWhere(
      (element) {
        return element.productID == e.productId;
      },
    );
    return LocalCartModel(
        id: e.id,
        userID: e.userID,
        productId: e.productId,
        storeId: e.storeId,
        quantity: e.quantity,
        recycleShopModel: storeDatastore,
        recycleProductModel: recycleProductData.copyWith(quantity: e.quantity));
  }).toList();

  return localCartData;
});
