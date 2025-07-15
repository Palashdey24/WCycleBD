import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd/data/model/remote/recycle_product_model.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/helper/sqlite_helper.dart';
import 'package:wcycle_bd/provider/order_cookies_provider.dart';

class CartItemRecycleInfo extends ConsumerWidget {
  const CartItemRecycleInfo(
      {super.key,
      required this.quantity,
      this.recycleProductModel,
      required this.onTap,
      required this.cartID});

  final int quantity;
  final String cartID;

  final RecycleProductModel? recycleProductModel;
  final void Function(bool selected) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int? cartQuantity;

    bool selectCart = false;

    cartQuantity ?? (cartQuantity = quantity);

    // * This line for see if the product already select for checkout or Not
    selectCart = ref.read(orderCookiesProvider).any(
          (element) => element.products.any(
            (element) => element.productID == recycleProductModel!.productID,
          ),
        );

    void onCartPlusFn() {
      if (cartQuantity! < 15) {
        cartQuantity = (cartQuantity! + 1);

        //* This line for update cart item Quantity in Local database
        SQLiteHelper.updateCartItem(cartID, context, cartQuantity!);

        if (selectCart) {
          //* If product already on select for checkout then update the quantity and price in provider
          ref
              .read(orderCookiesProvider.notifier)
              .updateQuantity(
                  isPlus: true,
                  productID: recycleProductModel!.productID,
                  storeId: recycleProductModel!.shopID,
                  quantity: cartQuantity!)
              .then(
            (value) {
              ref.read(totalPriceProvider.notifier).updateTotalPrice(value!);
            },
          );
        }
      } else {
        DialogsHelper.showMessage(
          context,
          "Can't add more than 15 item",
        );
      }

      return;
    }

    // ? This function for cart minus

    void onCartMinusFn() {
      if (cartQuantity! > 1) {
        cartQuantity = cartQuantity! - 1;
        //* This line for update minus cart item Quantity in Local database
        SQLiteHelper.updateCartItem(cartID, context, cartQuantity!);

        if (selectCart) {
          //* also updated the total price in provider
          ref
              .watch(orderCookiesProvider.notifier)
              .updateQuantity(
                  isPlus: false,
                  productID: recycleProductModel!.productID,
                  storeId: recycleProductModel!.shopID,
                  quantity: cartQuantity!)
              .then(
                (value) => ref
                    .watch(totalPriceProvider.notifier)
                    .updateTotalPrice(value!),
              );
        }
      } else {
        DialogsHelper.showMessage(
          context,
          "Can't item less than 1. Try delete",
        );
      }
    }

    return Flex(
      direction: Axis.horizontal,
      children: [
        Checkbox(
          value: selectCart,
          tristate: false,
          checkColor: Colors.orange,
          activeColor: Colors.black,
          shape: const StarBorder.polygon(),
          onChanged: (value) {
            selectCart = value!;
            onTap(selectCart);
          },
        ),
        Expanded(
            flex: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(normalGap),
              child: recycleProductModel?.productImage == null
                  ? Image.asset(
                      "assets/metal-field.jpg",
                    )
                  : CachedNetworkImage(
                      height: 50, imageUrl: recycleProductModel!.productImage),
            )),
        Expanded(
          flex: 50,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    direction: Axis.vertical,
                    spacing: 5,
                    children: [
                      Text(
                        recycleProductModel?.productName ?? "Plastic",
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        "\$ ${cartQuantity ?? quantity} x ${recycleProductModel?.productPrice}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(
                        "\$ ${(cartQuantity! * (recycleProductModel?.productPrice ?? 1)).toStringAsFixed(2)}",
                        style: const TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 20,
                  child: Flex(
                    direction: Axis.vertical,
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //* This line for remove item from local database and also update the provider
                          SQLiteHelper.removeCartItem(
                              recycleProductModel!.productID, context);
                          if (selectCart) {
                            ref
                                .watch(orderCookiesProvider.notifier)
                                .removeOrder(recycleProductModel!);
                          }
                        },
                        child: const FaIcon(FontAwesomeIcons.trashCan,
                            size: 20, color: Colors.black),
                      ),
                      Wrap(
                        spacing: 5,
                        children: [
                          GestureDetector(
                            onTap: onCartMinusFn,
                            child: const CircleAvatar(
                              radius: normalGap,
                              child: FaIcon(
                                FontAwesomeIcons.minus,
                                size: normalGap,
                              ),
                            ),
                          ),
                          Text(
                            "${cartQuantity ?? quantity}",
                            style: const TextStyle(color: Colors.lime),
                          ),
                          GestureDetector(
                            onTap: onCartPlusFn,
                            child: const CircleAvatar(
                              radius: normalGap,
                              child: FaIcon(
                                FontAwesomeIcons.plus,
                                size: normalGap,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
