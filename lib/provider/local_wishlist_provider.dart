import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/data/model/local/wishlist_database.dart';
import 'package:wcycle_bd/data/model/remote/recycle_product_model.dart';
import 'package:wcycle_bd/provider/recycable_fs_data.dart';

class LocalWishlistIntiProviderNotifier
    extends StateNotifier<List<Map<String, String>>> {
  LocalWishlistIntiProviderNotifier() : super([]);

  Future<bool> loadIntiWishData() async {
    final db = await WishlistDatabase.getDatabase();
    final wishlistDatabase = await db.query("wishlist");

    final wishlistData = wishlistDatabase
        .map((e) => {"productId": e['productId'] as String})
        .toList();
    state = wishlistData;
    return true;
  }
}

final localWishlistIntiProvider = StateNotifierProvider<
    LocalWishlistIntiProviderNotifier, List<Map<String, String>>>((ref) {
  return LocalWishlistIntiProviderNotifier();
});

final localWishProvider = Provider<List<RecycleProductModel>>((ref) {
  ref.read(localWishlistIntiProvider.notifier).loadIntiWishData();
  final localWish = ref.watch(localWishlistIntiProvider);
  final recycleProduct = ref.watch(recycleFsDataProvider);

  final localWishData = localWish.map((e) {
    final productData = recycleProduct.firstWhere(
      (element) {
        return element.productID == e['productId'];
      },
    );

    return productData;
  }).toList();

  return localWishData;
});
