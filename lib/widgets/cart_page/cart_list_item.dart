import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/widgets/cart_page/cart_item_recycle_info.dart';

final fontHelpers = FontHelper();

class CartListItem extends StatelessWidget {
  const CartListItem({super.key});

  @override
  Widget build(BuildContext context) {
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
                  "Shop Name",
                  style: fontHelpers
                      .bodySmall(context)
                      .copyWith(color: Colors.white),
                ),
                const Gap(normalGap),
              ],
            ),
            const CartItemRecycleInfo(),
            const CartItemRecycleInfo(),
          ],
        ),
      ),
    );
  }
}
