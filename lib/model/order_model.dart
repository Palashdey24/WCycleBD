import 'package:wcycle_bd/data/model/remote/recycle_product_model.dart';

class OrderModel {
  final String storeId;
  late double totalPrice;
  final String status;
  final List<RecycleProductModel> products;

  OrderModel({
    required this.storeId,
    required this.totalPrice,
    required this.status,
    required this.products,
  });
}
