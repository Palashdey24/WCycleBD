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

class ProductDetailsAddCart extends ConsumerWidget {
  const ProductDetailsAddCart({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const uuid = Uuid();

// Generate a v1 (time-based) id
    final randomId = uuid.v4();
    print("checking $randomId");

    final phoneWidth = DeviceSize.getDeviceWidth(context);
    ValueNotifier<int> cartItem = ValueNotifier<int>(0);
    final rcLM = ref.read(recycableProvider);

    // ? This function for cart plus
    void onAddCartFn(int quantity) async {
      if (quantity == 0) {
        cartItem.value++;
        return;
      } else {
        DialogsHelper.showProgressBar(context);

        final db = await CartDatabase.getDatabase();

        final check = await db.insert("carts", {
          "id": randomId,
          "productId": rcLM.productID,
          "storeId": rcLM.shopID,
          "quantity": quantity
        }).whenComplete(
          () {
            if (!context.mounted) return;
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ));
            return;
          },
        );
        print(check);

        return;
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
