import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/pages/store_page.dart';
import 'package:wcycle_bd/provider/individual_store_provider.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/card_with_outlined.dart';

class ShopCardWidget extends ConsumerWidget {
  const ShopCardWidget(
    this.shopId, {
    super.key,
  });

  final String shopId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(individualStoreProvider.notifier).shopData(context, shopId);
    final shopProvider = ref.watch(individualStoreProvider);
    ImageProvider shopImage = const AssetImage("assets/PersonAvater.png");

    if (shopProvider.logoUri != "N?A") {
      shopImage = NetworkImage(shopProvider.logoUri);
    }
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StorePage(shopModel: shopProvider),
          )),
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: CardWithOutlined(
            horiMargin: 30,
            cardWidget: Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 30,
                  child: CircleAvatar(
                    radius: 35,
                    foregroundImage: shopImage,
                  ),
                ),
                Expanded(
                    flex: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(5),
                        Text(
                          shopProvider.storeName,
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Gap(5),
                        Text(
                          "Address: ${shopProvider.locations.address}",
                          style: TextStyle(
                              fontSize: 12, color: Colors.yellow.shade100),
                        ),
                        const Gap(5),
                        Row(
                          children: [
                            const FaIcon(
                                size: 15,
                                color: Colors.red,
                                FontAwesomeIcons.solidStar),
                            const Gap(5),
                            Text(
                              "${shopProvider.rating}/${shopProvider.totalRated}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
