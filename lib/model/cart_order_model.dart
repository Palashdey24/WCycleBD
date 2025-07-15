import 'package:wcycle_bd/data/model/remote/recycle_product_model.dart';

class CartOrderModel {
  final String storeId;
  final String storeName;
  late double totalPrice;
  final String status;
  final List<RecycleProductModel> products;

  CartOrderModel({
    required this.storeName,
    required this.storeId,
    required this.totalPrice,
    required this.status,
    required this.products,
  });
}
