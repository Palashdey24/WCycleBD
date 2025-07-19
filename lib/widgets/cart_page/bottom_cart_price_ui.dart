import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/helper/device_size.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/pages/address_book_page.dart';
import 'package:wcycle_bd/provider/order_cookies_provider.dart';
import 'package:wcycle_bd/provider/select_address_provider.dart';
import 'package:wcycle_bd/provider/user_address_provider.dart';
import 'package:wcycle_bd/widgets/order_configure/order_configure.dart';

import '../../screen/ui_view/details/littered_spot_details.dart';

class BottomCartPriceUi extends ConsumerWidget {
  const BottomCartPriceUi({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ? This is for future use. So address configure for order can be work smoothly
    final userAddress = ref.watch(userAddressDataProvider);
    final defaultAddress = userAddress
        .where(
          (element) => element.isDefault == true,
        )
        .firstOrNull;

    // ? Code end here

    void defaultAddressNullDialog() {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Default Address Not Found",
                style: FontHelper()
                    .bodyMedium(context)
                    .copyWith(color: Colors.red)),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: FontHelper().bodySmall(context),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddressBookPage(),
                        ));
                  },
                  child: Text(
                    "Okay",
                    style: FontHelper().bodySmall(context),
                  )),
            ],
            content: Text(
              "Please add or Make a default address",
              style: FontHelper().bodySmall(context),
            ),
          );
        },
      );
    }

    void onCheckOut() {
      final orderDataList = ref.read(orderCookiesProvider);

      if (orderDataList.isNotEmpty) {
        if (defaultAddress == null) {
          defaultAddressNullDialog();
          return;
        }

        ref
            .read(selectedAddressProvider.notifier)
            .updateSelectedAddress(defaultAddress!);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OrderConfigure(),
            ));
/*        DialogsHelper.showProgressBar(context);
        for (var orderData in orderDataList) {
          FirebaseHelper.upFirestoreData({
            "storeId": orderData.storeId,
            "totalPrice": orderData.totalPrice,
            "status": orderData.status,
            "products": orderData.products.map((e) => e.toJsonWithId()).toList()
          }, "recycleOrder", context)
              .then(
            (value) {
              if (value != null) {
                for (var item in orderData.products) {
                  SQLiteHelper.removeCartItem(item.productID, context);
                }
              }
            },
          );
        }

        ref.invalidate(orderCookiesProvider);
        ref.invalidate(totalPriceProvider);
        Navigator.pop(context);*/
      } else {
        DialogsHelper.showMessage(context, "No Order Selected Yet");
      }
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
            child: Text("Check Out", style: fontHelpers.bodyMedium(context)),
          )
        ],
      ),
    );
  }
}
