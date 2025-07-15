import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/data/model/remote/recycle_product_model.dart';
import 'package:wcycle_bd/helper/pre_style.dart';

class OrderItemRecycleInfo extends ConsumerWidget {
  const OrderItemRecycleInfo({
    super.key,
    required this.quantity,
    this.recycleProductModel,
  });

  final int quantity;
  final RecycleProductModel? recycleProductModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int? cartQuantity;

    cartQuantity ?? (cartQuantity = quantity);

    return Flex(
      direction: Axis.horizontal,
      children: [
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
      ],
    );
  }
}
