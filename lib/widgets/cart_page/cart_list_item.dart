import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/provider/provider_scope/cartListItemProvider.dart';
import 'package:wcycle_bd/widgets/cart_page/cart_item_recycle_info.dart';

final fontHelpers = FontHelper();

class CartListItem extends ConsumerWidget {
  const CartListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartData = ref.watch(cartItemProvider);
    return Card(
      color: Colors.transparent,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.shop,
                  size: 15,
                  color: Colors.blueGrey,
                ),
                const Gap(normalGap),
                Text(
                  cartData.recycleShopModel?.storeName ?? "Shop Name",
                  style: fontHelpers
                      .bodySmall(context)
                      .copyWith(color: Colors.white),
                ),
                const Gap(normalGap),
              ],
            ),
            CartItemRecycleInfo(
              quantity: cartData.quantity,
              recycleProductModel: cartData.recycleProductModel,
            ),
          ],
        ),
      ),
    );
  }
}
