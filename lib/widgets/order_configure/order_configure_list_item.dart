import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/provider/provider_scope/order_list_Item_provider.dart';
import 'package:wcycle_bd/widgets/order_configure/order_item_recycle_info.dart';

final fontHelpers = FontHelper();

class OrderConfigureListItem extends ConsumerWidget {
  const OrderConfigureListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //* This function for load item StoreName provided by river-pod
    final orderStoreName = ref.read(orderStoreProvider);

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
                  orderStoreName,
                  style: fontHelpers
                      .bodySmall(context)
                      .copyWith(color: Colors.white),
                ),
                const Gap(normalGap),
              ],
            ),
            builder: (context, ref, child) {
              //* Take the list of product data for the specific store name
              final orderProductList = ref.watch(orderItemListProvider);
              return Column(
                children: [
                  child!,
                  for (var orderProducts in orderProductList)
                    OrderItemRecycleInfo(
                      quantity: orderProducts.quantity!,
                      recycleProductModel: orderProducts,
                    ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Shopping Fee: ",
                              style: fontHelpers.bodySmall(context)),
                          TextSpan(
                              text: " ৳ 125",
                              style: fontHelpers.bodyMedium(context).copyWith(
                                  color: Colors.white,
                                  decoration: TextDecoration.lineThrough)),
                          TextSpan(
                              text: " 0",
                              style: fontHelpers
                                  .bodyMedium(context)
                                  .copyWith(color: Colors.orange))
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
