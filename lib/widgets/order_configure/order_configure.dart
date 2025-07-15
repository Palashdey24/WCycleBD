import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/helper/device_size.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/provider/order_cookies_provider.dart';
import 'package:wcycle_bd/provider/provider_scope/order_list_Item_provider.dart';
import 'package:wcycle_bd/widgets/order_configure/bottom_order_price_ui.dart';
import 'package:wcycle_bd/widgets/order_configure/order_address_ui.dart';
import 'package:wcycle_bd/widgets/order_configure/order_configure_list_item.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/back_custom_button.dart';

class OrderConfigure extends ConsumerWidget {
  const OrderConfigure({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderDataList = ref.read(orderCookiesProvider);

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
                  spacing: normalGap,
                  children: [
                    const BackCustomButton(),
                    const OrderAddressUi(),
                    Expanded(
                        child: ListView.builder(
                      itemCount: orderDataList.length,
                      itemBuilder: (context, index) {
                        return ProviderScope(
                          key: ValueKey(orderDataList[index].storeId),
                          overrides: [
                            //* This below line sent individual item data from sequenceAllCarts

                            orderItemListProvider.overrideWithValue(
                                orderDataList[index].products),
                            orderStoreIDProvider.overrideWithValue(
                                orderDataList[index].storeId),
                            orderStoreProvider.overrideWithValue(
                                orderDataList[index].storeName),
                          ],
                          child: const OrderConfigureListItem(),
                        );
                      },
                    ))
                  ],
                ),
              ),
            ],
          ),
          const Positioned(bottom: 0, child: BottomOrderPriceUi()),
        ],
      ),
    );
  }
}
