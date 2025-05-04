import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wcycle_bd/helper/device_size.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/local_cart_model.dart';
import 'package:wcycle_bd/provider/local_cart_provider.dart';
import 'package:wcycle_bd/screen/ui_view/shimmer/recycle_shimmer.dart';
import 'package:wcycle_bd/widgets/cart_page/cart_list_item.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/back_custom_button.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  late Future<List<LocalCartModel>?> _loadCart;
  late List<LocalCartModel> _loadAllCart;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCart = ref.read(localCartIntiProvider.notifier).loadIntiCartData();
    _loadAllCart = ref.read(localCartProvider);
  }

  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: [
          SizedBox(
            height: DeviceSize.getDeviceHeight(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackCustomButton(),
                Expanded(
                  child: /*localCart.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.only(bottom: 100),
                          itemCount: localCart.length,
                          itemBuilder: (context, index) {
                            return CartListItem(
                              cartModel: localCart[index],
                            );
                          },
                        )
                      : emptyCart*/
                      FutureBuilder(
                    future: _loadCart,
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
                            final cartData = snapshot.data;
                            //Add data to model list one after one

                            return (cartData != null || cartData!.isNotEmpty)
                                ? ListView.builder(
                                    padding: const EdgeInsets.only(bottom: 100),
                                    itemCount: _loadAllCart.length,
                                    itemBuilder: (context, index) {
                                      return CartListItem(
                                        cartModel: _loadAllCart[index],
                                      );
                                    },
                                  )
                                : emptyCart;
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
    );
  }
}
