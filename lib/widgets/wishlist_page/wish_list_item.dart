import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/helper/sqlflite_helper.dart';
import 'package:wcycle_bd/provider/provider_scope/wishListItemProvider.dart';
import 'package:wcycle_bd/provider/recycable_provider.dart';
import 'package:wcycle_bd/screen/ui_view/details/recycable_product_details.dart';

final fontHelpers = FontHelper();

class WishListItem extends ConsumerWidget {
  const WishListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productData = ref.read(wishItemProvider);
    return GestureDetector(
      onTap: () {
        DialogsHelper.showProgressBar(context);
        ref.read(recycableProvider.notifier).onChange(productData).then(
          (value) {
            if (!context.mounted) return;
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecycleProductDetails(),
                ));
          },
        );
      },
      child: Card(
        color: Colors.transparent,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Flex(
            direction: Axis.horizontal,
            spacing: csGap,
            children: [
              Expanded(
                flex: 3,
                child: CachedNetworkImage(
                  imageUrl: productData.productImage,
                  fadeInCurve: Curves.bounceIn,
                  height: 50,
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  spacing: csGap,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      productData.productName,
                      style: fontHelpers
                          .bodyMedium(context)
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      "৳ ${productData.productPrice}",
                      style: fontHelpers
                          .bodyMedium(context)
                          .copyWith(color: Colors.lime),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () => SqlfliteHelper.removeWishList(
                                productData.productID, context),
                            icon: const FaIcon(
                              FontAwesomeIcons.trash,
                              size: csGap,
                              color: Colors.red,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const FaIcon(
                              FontAwesomeIcons.cartPlus,
                              size: csGap,
                              color: Colors.orange,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
