import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd/data/model/remote/recycle_product_model.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';

class CartItemRecycleInfo extends StatefulWidget {
  const CartItemRecycleInfo(
      {super.key, required this.quantity, this.recycleProductModel});

  final int quantity;
  final RecycleProductModel? recycleProductModel;

  @override
  State<CartItemRecycleInfo> createState() => _CartItemRecycleInfoState();
}

class _CartItemRecycleInfoState extends State<CartItemRecycleInfo> {
  int? cartItem;

  bool selectCart = false;

  @override
  Widget build(BuildContext context) {
    cartItem ?? (cartItem = widget.quantity);

    void onCartPlusFn() {
      if (cartItem! < 15) {
        setState(() {
          cartItem = (cartItem! + 1);
        });
      } else {
        DialogsHelper.showMessage(
          context,
          "Can't add more than 15 item",
        );
      }
    }

    // ? This function for cart minus

    void onCartMinusFn() {
      if (cartItem! > 1) {
        setState(() {
          cartItem = cartItem! - 1;
        });
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
        Radio(
          value: selectCart,
          groupValue: selectCart,
          fillColor: WidgetStateProperty.all(Colors.white),
          activeColor: Colors.green,
          onChanged: (value) {
            selectCart = value!;
            log(value.toString());
          },
        ),
        Expanded(
            flex: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(normalGap),
              child: widget.recycleProductModel?.productImage == null
                  ? Image.asset(
                      "assets/metal-field.jpg",
                    )
                  : CachedNetworkImage(
                      height: 50,
                      imageUrl: widget.recycleProductModel!.productImage),
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
                        widget.recycleProductModel?.productName ?? "Plastic",
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        "\$ ${cartItem ?? widget.quantity} x ${widget.recycleProductModel?.productPrice}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(
                        "\$ ${(cartItem! * (widget.recycleProductModel?.productPrice ?? 1)).toStringAsFixed(2)}",
                        style: const TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 20,
                  child: Wrap(
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
                        "${cartItem ?? widget.quantity}",
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
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
