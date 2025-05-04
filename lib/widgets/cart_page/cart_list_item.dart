import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/local_cart_model.dart';
import 'package:wcycle_bd/model/store_model.dart';
import 'package:wcycle_bd/widgets/cart_page/cart_item_recycle_info.dart';

final fontHelpers = FontHelper();

class CartListItem extends ConsumerStatefulWidget {
  const CartListItem({
    super.key,
    required this.cartModel,
  });

  final LocalCartModel cartModel;

  @override
  ConsumerState<CartListItem> createState() => _CartListItemState();
}

class _CartListItemState extends ConsumerState<CartListItem> {
  late StoreModel storeData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
/*    final allStoreData = ref.watch(storeFsDataProvider);
    storeData = allStoreData.firstWhere((element) {
      return element.id == widget.cartModel.storeId;
    });*/
  }

  @override
  Widget build(
    BuildContext context,
  ) {
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
                  widget.cartModel.recycleShopModel?.storeName ?? "Shop Name",
                  style: fontHelpers
                      .bodySmall(context)
                      .copyWith(color: Colors.white),
                ),
                const Gap(normalGap),
              ],
            ),
            CartItemRecycleInfo(
              quantity: widget.cartModel.quantity,
            ),
            CartItemRecycleInfo(
              quantity: widget.cartModel.quantity,
            ),
          ],
        ),
      ),
    );
  }
}
