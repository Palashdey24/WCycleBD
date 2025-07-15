import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/data/model/remote/recycle_product_model.dart';
import 'package:wcycle_bd/model/cart_order_model.dart';
import 'package:wcycle_bd/model/local_cart_model.dart';

class OrderCookiesNotifierProvider extends StateNotifier<List<CartOrderModel>> {
  OrderCookiesNotifierProvider() : super([]);

  //* This function help to found the index of the store in the orderList
  int? indexCheck(String storeId) {
    List<CartOrderModel> orderList = state;
    int? index;
    orderList.any((element) {
      if (element.storeId == storeId) {
        index = orderList.indexOf(element);
        return true;
      }
      return false;
    });

    return index;
  }

  Future<double> saveOrder(LocalCartModel localCart, int quantity) async {
    List<CartOrderModel> orderList = state;
    int? index;

    index = indexCheck(
      localCart.storeId,
    );

    //* Updated the quantity in specific cart data

    RecycleProductModel recycleProduct =
        localCart.recycleProductModel!.copyWith(quantity: quantity);

    /** Check the store name already in the orderList or not.
    If has then add product in the store Product list.
        Otherwise add the data in new column
    **/
    final updatedPrice = localCart.quantity * recycleProduct.productPrice;
    if (index != null) {
      orderList[index].products.add(recycleProduct);
      orderList[index].totalPrice +=
          (localCart.quantity * recycleProduct.productPrice);

      state = orderList;
      return updatedPrice;
    } else {
      orderList.add(CartOrderModel(
          storeId: localCart.storeId,
          totalPrice: (localCart.quantity * recycleProduct.productPrice),
          status: "initials",
          products: [recycleProduct],
          storeName: localCart.recycleShopModel!.storeName));

      state = orderList;

      log(state.length.toString());

      return updatedPrice;
    }
  }

  Future<double?> updateQuantity(
      {required String storeId,
      required String productID,
      required int quantity,
      required bool isPlus}) async {
    int? index;
    int productIndex;

    List<CartOrderModel> orderList = state;
    index = indexCheck(
      storeId,
    );
    double? updatedOrderPriceBtm;

    if (orderList.isNotEmpty) {
      //* Query the index for the product Index in the Store Product List
      productIndex = orderList[index!]
          .products
          .indexWhere((element) => element.productID == productID);

      if (!productIndex.isNegative) {
        if (isPlus) {
          orderList[index].totalPrice +=
              orderList[index].products[productIndex].productPrice;
          updatedOrderPriceBtm =
              orderList[index].products[productIndex].productPrice;
        } else {
          orderList[index].totalPrice -=
              orderList[index].products[productIndex].productPrice;

          updatedOrderPriceBtm =
              -orderList[index].products[productIndex].productPrice;
        }
      }

      state = orderList;

      return updatedOrderPriceBtm;
    }
    return null;
  }

  Future<double> removeOrder(RecycleProductModel recycleProduct) async {
    int? index;
    List<CartOrderModel> orderList = state;
    index = indexCheck(
      recycleProduct.shopID,
    );

    final removedPrice =
        (recycleProduct.quantity! * recycleProduct.productPrice);

    if (index != null && orderList[index].products.length > 1) {
      orderList[index].products.removeWhere(
            (element) => element.productID == recycleProduct.productID,
          );

      orderList[index].totalPrice -=
          (recycleProduct.quantity! * recycleProduct.productPrice);
      state = orderList;
      log(state[index].totalPrice.toString());
      return -removedPrice;
    } else {
      orderList.removeWhere(
        (element) => element.storeId == recycleProduct.shopID,
      );
      state = orderList;

      return -removedPrice;
    }
  }
}

final orderCookiesProvider =
    StateNotifierProvider<OrderCookiesNotifierProvider, List<CartOrderModel>>(
        (ref) {
  return OrderCookiesNotifierProvider();
});

class TotalPriceProviderNotifier extends StateNotifier<double> {
  TotalPriceProviderNotifier() : super(0.0);

  void updateTotalPrice(double price) {
    state = state + price;
  }
}

final totalPriceProvider =
    StateNotifierProvider<TotalPriceProviderNotifier, double>((ref) {
  return TotalPriceProviderNotifier();
});
