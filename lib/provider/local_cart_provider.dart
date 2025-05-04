import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/data/model/local/cart_database.dart';
import 'package:wcycle_bd/model/local_cart_model.dart';
import 'package:wcycle_bd/provider/store_fs_data.dart';

class LocalCartIntiProviderNotifier extends StateNotifier<List<LocalCartModel>> {
  LocalCartIntiProviderNotifier() : super([]);

  Future<List<LocalCartModel>?> loadIntiCartData() async {
    final db = await CartDatabase.getDatabase();
    final cartDatabase = await db.query("carts");

    final cartData = cartDatabase
        .map((e) => LocalCartModel(
            id: e['id'] as String,
            productId: e['productId'] as String,
            storeId: e['storeId'] as String,
            quantity: e['quantity'] as int))
        .toList();
    state = cartData;
    return cartData;
  }
}

final localCartIntiProvider =
    StateNotifierProvider<LocalCartIntiProviderNotifier, List<LocalCartModel>>(
        (ref) {
  return LocalCartIntiProviderNotifier();
});











final localCartProvider = Provider<List<LocalCartModel>>((ref) {
   ref.read(localCartIntiProvider.notifier).loadIntiCartData();
   final localCart =ref.watch(localCartIntiProvider);
  final storeData = ref.watch(storeFsDataProvider);

  final localCartData = localCart.map((e) {
    final storeDatastore = storeData.firstWhere(
      (element) {
        return element.id == e.storeId;
      },
    );
    return LocalCartModel(
      id: e.id,
      productId: e.productId,
      storeId: e.storeId,
      quantity: e.quantity,
    recycleShopModel: storeDatastore);
  }).toList();

  return localCartData;
});