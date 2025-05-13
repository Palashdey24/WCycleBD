import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';
import 'package:wcycle_bd/helper/device_size.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/helper/sqlite_helper.dart';
import 'package:wcycle_bd/provider/local_cart_provider.dart';
import 'package:wcycle_bd/provider/recycable_provider.dart';
import 'package:wcycle_bd/screen/ui_view/details/recycable_details/custom_plus_minus_item_core.dart';

const uuid = Uuid();

// Generate a v1 (time-based) id

class ProductDetailsAddCart extends ConsumerWidget {
  const ProductDetailsAddCart({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? previousId;
    final randomId = uuid.v4();
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final phoneWidth = DeviceSize.getDeviceWidth(context);
    ValueNotifier<int> cartItem = ValueNotifier<int>(0);
    final rcLM = ref.watch(recycableProvider);

    final cartList = ref.read(localCartProvider);

    final inCart = cartList.any((element) {
      if (element.productId == rcLM.productID) {
        cartItem.value = element.quantity;
        previousId = element.id;
        return true;
      } else {
        cartItem.value = 0;
        return false;
      }
    });

    // ? This function for cart plus
    void onAddCartFn(int quantity) async {
      if (cartItem.value == 0) {
        cartItem.value++;
        return;
      } else {
        SQLiteHelper.addCartSql(context, randomId, rcLM.shopID, rcLM.productID,
            quantity, userId, inCart, previousId);
      }
    }

    void onCartPlusFn() {
      if (cartItem.value < 15) {
        cartItem.value++;
      } else {
        DialogsHelper.showMessage(
          context,
          "Can't add more than 15 item",
        );
      }
    }

    // ? This function for cart minus

    void onCartMinusFn() {
      cartItem.value--;
    }

    return ValueListenableBuilder(
      valueListenable: cartItem,
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (cartItem.value > 0)
              Card(
                color: Colors.greenAccent,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                elevation: csGap,
                child: CustomPlusMinusItemCore(
                    onPlusFn: onCartPlusFn,
                    onMinusFn: onCartMinusFn,
                    quantity: cartItem.value),
              ),
            if (cartItem.value > 0) const Gap(largeGap),
            ElevatedButton(
              onPressed: () => onAddCartFn(cartItem.value),
              style: ElevatedButton.styleFrom(
                backgroundColor: cartItem.value != 0
                    ? const Color.fromARGB(207, 5, 23, 7)
                    : null,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                elevation: csGap,
                minimumSize: Size(
                    cartItem.value != 0 ? phoneWidth * 0.45 : phoneWidth * 0.75,
                    50),
              ),
              child: Text(
                cartItem.value == 0 ? "Add To Cart" : "Checkout",
                softWrap: true,
                style: FontHelper()
                    .bodyMedium(context)
                    .copyWith(color: Colors.blueGrey),
              ),
            ),
          ],
        );
      },
    );
  }
}
