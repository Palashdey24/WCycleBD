import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/helper/device_size.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/provider/local_wishlist_provider.dart';
import 'package:wcycle_bd/provider/provider_scope/wishListItemProvider.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/back_custom_button.dart';
import 'package:wcycle_bd/widgets/wishlist_page/wish_list_item.dart';

class WishlistsPage extends ConsumerWidget {
  const WishlistsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: ListView(
        children: [
          SizedBox(
            height: DeviceSize.getDeviceHeight(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: normalGap,
              children: [
                const BackCustomButton(),
                Expanded(
                  child: Consumer(builder: (context, ref, child) {
                    final wishlists = ref.watch(localWishProvider);
                    log(wishlists.length);
                    return wishlists.isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.only(bottom: 100),
                            itemCount: wishlists.length,
                            itemBuilder: (context, index) {
                              return ProviderScope(
                                key: ValueKey<String>(
                                    wishlists[index].productID),
                                overrides: [
                                  wishItemProvider
                                      .overrideWithValue(wishlists[index]),
                                ],
                                child: const WishListItem(),
                              );
                            },
                          )
                        : const Center(
                            child: Text("No Wishlist Items",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)));
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
