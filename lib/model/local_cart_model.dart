import 'package:wcycle_bd/model/store_model.dart';

class LocalCartModel {
  LocalCartModel({
    required this.id,
    required this.productId,
    required this.storeId,
    required this.quantity,
    this.recycleShopModel,
  });

  final String id;
  final String productId;
  final String storeId;
  final int quantity;
  final StoreModel? recycleShopModel;
}
