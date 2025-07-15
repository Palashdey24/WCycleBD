import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/helper/device_size.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/helper/firebase_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/helper/sqlite_helper.dart';
import 'package:wcycle_bd/provider/order_cookies_provider.dart';
import 'package:wcycle_bd/provider/select_address_provider.dart';
import 'package:wcycle_bd/utilts/string.dart';

import '../../screen/ui_view/details/littered_spot_details.dart';

class BottomOrderPriceUi extends ConsumerWidget {
  const BottomOrderPriceUi({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onCheckOut() {
      final orderDataList = ref.read(orderCookiesProvider);
      final selectAddress = ref.read(selectedAddressProvider);

      List<Map<String, dynamic>> orderStatus = [];
      List<Map<String, dynamic>> metaData = [];

      orderStatus
          .add({"status": "Placed", "Time": formatedOrderDate(DateTime.now())});

      metaData.add({"metaData": "10% Discount", "metaName": "Coupon"});
      metaData.add({"metaData": "Cash On Delivery", "metaName": "Payment"});

      DialogsHelper.showProgressBar(context);
      for (var orderData in orderDataList) {
        FirebaseHelper.upFirestoreData({
          "storeId": orderData.storeId,
          "totalPrice": orderData.totalPrice,
          "status": orderStatus.toList(),
          "address": selectAddress[0].toJson(),
          "metaData": metaData
              .map(
                (e) => e,
              )
              .toList(),
          "products": orderData.products.map((e) => e.toJsonWithId()).toList()
        }, "recycleOrder", context)
            .then(
          (value) {
            if (value != null) {
              for (var item in orderData.products) {
                if (!context.mounted) return;
                SQLiteHelper.removeCartItem(item.productID, context);
              }
            }
          },
        );
      }

      ref.invalidate(orderCookiesProvider);
      ref.invalidate(totalPriceProvider);
      Navigator.of(context)
        ..pop()
        ..pop();
    }

    return Container(
      width: DeviceSize.getDeviceWidth(context),
      height: 120,
      decoration: const BoxDecoration(color: Colors.white),
      child: Flex(
        direction: Axis.horizontal,
        spacing: csGap,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Consumer(builder: (context, ref, child) {
                final orderTotalCookies = ref.watch(totalPriceProvider);
                return RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Approx Total: ",
                          style: fontHelpers.bodyMedium(context)),
                      TextSpan(
                          text: " ৳ ${orderTotalCookies.toStringAsFixed(3)}",
                          style: fontHelpers
                              .bodyMedium(context)
                              .copyWith(color: Colors.orange))
                    ],
                  ),
                );
              }),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Shopping Fee: ",
                        style: fontHelpers.bodySmall(context)),
                    TextSpan(
                        text: " ৳ 125",
                        style: fontHelpers.bodyMedium(context).copyWith(
                            color: Colors.orange,
                            decoration: TextDecoration.lineThrough)),
                    TextSpan(
                        text: " 0",
                        style: fontHelpers
                            .bodyMedium(context)
                            .copyWith(color: Colors.orange))
                  ],
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: onCheckOut,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.all(normalGap)),
            child: Text("Place Order", style: fontHelpers.bodyMedium(context)),
          )
        ],
      ),
    );
  }
}
