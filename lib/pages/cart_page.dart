import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wcycle_bd/helper/device_size.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/local_cart_model.dart';
import 'package:wcycle_bd/provider/local_cart_provider.dart';
import 'package:wcycle_bd/provider/provider_scope/cart_list_Item_provider.dart';
import 'package:wcycle_bd/provider/select_address_provider.dart';
import 'package:wcycle_bd/provider/user_address_provider.dart';
import 'package:wcycle_bd/screen/ui_view/shimmer/recycle_shimmer.dart';
import 'package:wcycle_bd/widgets/cart_page/bottom_cart_price_ui.dart';
import 'package:wcycle_bd/widgets/cart_page/cart_list_item.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/back_custom_button.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //* This function for load cart data from local database
    Future<List<LocalCartModel>?> loadCart =
        ref.read(localCartIntiProvider.notifier).loadIntiCartData();

    // ? This is for future use. So address configure for order can be work smoothly
    final userAddress = ref.read(userAddressDataProvider);
    final defaultAddress = userAddress
        .where(
          (element) => element.isDefault == true,
        )
        .first;
    ref
        .read(selectedAddressProvider.notifier)
        .updateSelectedAddress(defaultAddress);

    // ? Code end here

    Widget emptyCart = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: normalGap,
        children: [
          SvgPicture.asset(
            "assets/recycle-308817.svg",
            semanticsLabel: 'Empty Cart',
          ),
          Text(
            "No Cart yet",
            style: FontHelper()
                .bodyLarge(context)
                .copyWith(color: Colors.greenAccent),
          ),
        ],
      ),
    );
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(
                height: DeviceSize.getDeviceHeight(context) - 125,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackCustomButton(),
                    Expanded(
                      child: FutureBuilder(
                        future: loadCart,
                        builder: (context, snapshot) {
                          {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                              case ConnectionState.none:
                                return const SizedBox(
                                  height: 200,
                                  child: RecycleShimmer(),
                                );
                              case ConnectionState.active:
                              case ConnectionState.done:
                                //Add data to model list one after one

                                return Consumer(builder: (context, ref, child) {
                                  //* This list filter load cart data by UserId & newest cart order

                                  final sequenceAllCarts =
                                      ref.watch(localCartProvider);

                                  List<String> cartStore = [];

                                  //** This loop for filter unique cart store name from the all sequenceAllCarts list
                                  for (var element in sequenceAllCarts) {
                                    if (!cartStore.contains(
                                        element.recycleShopModel!.storeName)) {
                                      cartStore.add(
                                          element.recycleShopModel!.storeName);
                                    }
                                  }
                                  return sequenceAllCarts.isNotEmpty
                                      ? ListView.builder(
                                          padding: const EdgeInsets.only(
                                              bottom: 100),
                                          itemCount: cartStore.length,
                                          itemBuilder: (context, index) {
                                            //* This list for filter out of List<LocalCartData> by store name
                                            final cartsData = sequenceAllCarts
                                                .where((element) {
                                              return element.recycleShopModel!
                                                      .storeName ==
                                                  cartStore[index];
                                            }).toList();

                                            return ProviderScope(
                                              key: ValueKey(
                                                  sequenceAllCarts[index].id),
                                              overrides: [
                                                //* This below line sent individual item data from sequenceAllCarts

                                                cartItemListProvider
                                                    .overrideWithValue(
                                                        cartsData),
                                                cartStoreIDProvider
                                                    .overrideWithValue(
                                                        sequenceAllCarts[index]
                                                            .id),
                                                cartStoreProvider
                                                    .overrideWithValue(
                                                        cartStore[index]),
                                              ],
                                              child: const CartListItem(),
                                            );
                                          },
                                        )
                                      : emptyCart;
                                });
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Positioned(bottom: 0, child: BottomCartPriceUi()),
        ],
      ),
    );
  }
}
