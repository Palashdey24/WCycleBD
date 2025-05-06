import 'package:wcycle_bd/data/model/remote/recycle_product_model.dart';
import 'package:wcycle_bd/model/store_model.dart';

class LocalCartModel {
  LocalCartModel({
    required this.id,
    required this.userID,
    required this.productId,
    required this.storeId,
    required this.quantity,
    this.recycleShopModel,
    this.recycleProductModel,
  });

  final String id;
  final String userID;
  final String productId;
  final String storeId;
  final int quantity;
  final StoreModel? recycleShopModel;
  final RecycleProductModel? recycleProductModel;
}
