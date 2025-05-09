import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/helper/sqlflite_helper.dart';
import 'package:wcycle_bd/provider/local_wishlist_provider.dart';
import 'package:wcycle_bd/provider/recycable_provider.dart';
import 'package:wcycle_bd/provider/recycle_recommend_provider.dart';
import 'package:wcycle_bd/screen/ui_view/details/recycable_details/product_details_add_cart.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/details_ui_kpi.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/info_card_widget.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/back_custom_button.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/custome_gridview.dart';

final api = Apis();
final fontHelpers = FontHelper();

class RecycleProductDetails extends ConsumerWidget {
  const RecycleProductDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<bool> isWish = ValueNotifier(false);
    final rcLM = ref.read(recycableProvider);
    final rcLMFn = ref.read(recycableProvider.notifier);
    ref.read(recyclerecommendProvider.notifier).recommendate(
          rcLM.productName,
        );

    final rcRecommend = ref.watch(recyclerecommendProvider);
    final wishList = ref.watch(localWishProvider);

    wishList.any((element) {
      if (element.productID == rcLM.productID) {
        isWish.value = true;
        return true;
      } else {
        isWish.value = false;
        return false;
      }
    });

    return Scaffold(
      floatingActionButton: const Padding(
        padding: EdgeInsets.all(8.0),
        child: ProductDetailsAddCart(),
      ),
      body: ListView(
        children: [
          Container(
            height: api.deviceHeight(context),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Colors.green,
            ], begin: Alignment.topCenter, end: Alignment.bottomLeft)),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: api.deviceHeight(context) * 0.26,
                      child: CachedNetworkImage(imageUrl: rcLM.productImage),
                    ),
                    Expanded(
                      child: Stack(
                        clipBehavior: Clip.antiAlias,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Card(
                              color: Colors.white,
                              elevation: 10,
                              margin: const EdgeInsets.only(top: 17),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DetailsUiKpi(
                                        kpiOneV: rcLM.productName,
                                        kpiTwoV: "\$ ${rcLM.productPrice}",
                                        kpiThreeH: rcLM.impactLevel),
                                    const Gap(csGap),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 8),
                                        child: InfoCardWidget(
                                          dataId: rcLM.shopID,
                                        )),
                                    const Gap(normalGap),
                                    Text(
                                      "Recommendation",
                                      style: fontHelpers.bodyMedium(context),
                                    ),
                                    const Gap(normalGap),
                                    Expanded(
                                      child: CustomeGridview(
                                        rcList: rcRecommend,
                                        isDtpage: true,
                                        onTap: (index) {
                                          rcLMFn.onChange(rcRecommend[index]);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 5,
                            child: ValueListenableBuilder(
                                valueListenable: isWish,
                                builder: (context, value, child) {
                                  return GestureDetector(
                                    onTap: () => !isWish.value
                                        ? SqlfliteHelper.addWishList(
                                            rcLM.productID, context)
                                        : SqlfliteHelper.removeWishList(
                                            rcLM.productID, context),
                                    child: CircleAvatar(
                                      radius: 17,
                                      child: Icon(
                                        Icons.favorite_rounded,
                                        color: isWish.value
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const BackCustomButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
