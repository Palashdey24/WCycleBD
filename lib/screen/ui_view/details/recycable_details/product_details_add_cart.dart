import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';
import 'package:wcycle_bd/data/model/local/cart_database.dart';
import 'package:wcycle_bd/helper/device_size.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/pages/cart_page.dart';
import 'package:wcycle_bd/provider/recycable_provider.dart';
import 'package:wcycle_bd/screen/ui_view/details/recycable_details/custom_plus_minus_item_core.dart';

const uuid = Uuid();

// Generate a v1 (time-based) id

class ProductDetailsAddCart extends ConsumerWidget {
  const ProductDetailsAddCart({
    super.key,
  });

  static void addCartSql(BuildContext context, String randomId, String storeId,
      String productId, int quantity, String userId) async {
    DialogsHelper.showProgressBar(context);

    final db = await CartDatabase.getDatabase();

    await db.insert("carts", {
      "id": randomId,
      "userID": userId,
      "productId": productId,
      "storeId": storeId,
      "quantity": quantity
    }).then(
      (value) {
        if (value >= 1 && context.mounted) {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ));
          return;
        }
        if (!context.mounted) return;
        Navigator.of(context);

        DialogsHelper.showMessage(context, "Something went wrong");
        return;
      },
    ).onError(
      (error, stackTrace) {
        if (!context.mounted) return;
        Navigator.of(context);
        DialogsHelper.showMessage(context, "Something went wrong $error");
      },
    );

    return;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final randomId = uuid.v4();
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final phoneWidth = DeviceSize.getDeviceWidth(context);
    ValueNotifier<int> cartItem = ValueNotifier<int>(0);
    final rcLM = ref.read(recycableProvider);

    // ? This function for cart plus
    void onAddCartFn(int quantity) async {
      if (quantity == 0) {
        cartItem.value++;
        return;
      } else {
        addCartSql(
            context, randomId, rcLM.shopID, rcLM.productID, quantity, userId);
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
