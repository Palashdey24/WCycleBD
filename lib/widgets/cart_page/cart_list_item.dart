import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/provider/order_cookies_provider.dart';
import 'package:wcycle_bd/provider/provider_scope/cartListItemProvider.dart';
import 'package:wcycle_bd/widgets/cart_page/cart_item_recycle_info.dart';

final fontHelpers = FontHelper();

class CartListItem extends ConsumerWidget {
  const CartListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //* This function for load item StoreName provided by river-pod
    final cartStore = ref.read(cartStoreProvider);

    return Card(
      color: Colors.transparent,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer(
            child: Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.shop,
                  size: 15,
                  color: Colors.blueGrey,
                ),
                const Gap(normalGap),
                Text(
                  cartStore,
                  style: fontHelpers
                      .bodySmall(context)
                      .copyWith(color: Colors.white),
                ),
                const Gap(normalGap),
              ],
            ),
            builder: (context, ref, child) {
              //* Take the list of product data for the specific store name
              final cartData = ref.watch(cartItemListProvider);
              return Column(
                children: [
                  child!,
                  for (var carts in cartData)
                    CartItemRecycleInfo(
                      onTap: (selected) {
                        //* For adding the order data to provider for future use
                        selected
                            ? ref
                                .read(orderCookiesProvider.notifier)
                                .saveOrder(carts, carts.quantity)
                                .then(
                                (value) {
                                  ref
                                      .read(totalPriceProvider.notifier)
                                      .updateTotalPrice(value);
                                },
                              )
                            : ref
                                .read(orderCookiesProvider.notifier)
                                .removeOrder(carts.recycleProductModel!)
                                .then(
                                (value) {
                                  ref
                                      .read(totalPriceProvider.notifier)
                                      .updateTotalPrice(value);
                                },
                              );
                      },
                      cartID: carts.id,
                      quantity: carts.quantity,
                      recycleProductModel: carts.recycleProductModel,
                    ),
                ],
              );
            }),
      ),
    );
  }
}
