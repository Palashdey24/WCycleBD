import 'package:wcycle_bd/model/local_cart_model.dart';

class CartStoreModel {
  CartStoreModel({
    required this.carts,
  });

  final Map<String, List<LocalCartModel>> carts;
}
