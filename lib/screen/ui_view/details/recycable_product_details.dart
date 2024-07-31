import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/data/recycable_price_data.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/provider/recycable_provider.dart';
import 'package:wcycle_bd/screen/ui_view/details/recycable_details/bottom_floating_widgets.dart';
import 'package:wcycle_bd/screen/ui_view/details/recycable_details/shop_card_widget.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/details_ui_kpi.dart';
import 'package:wcycle_bd/utilts/string.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/back_custom_button.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/custome_gridview.dart';

final api = Apis();
final fontHelpers = FontHelper();

class RecycableProductDetails extends ConsumerWidget {
  const RecycableProductDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rcLM = ref.watch(recycableProvider);
    final rcLMFn = ref.read(recycableProvider.notifier);

    final rcRecommend = recyclable.where(
      (element) {
        return element.rcName != rcLM.rcName;
      },
    ).toList();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: const BottomFloatingWidgets(),
        body: SingleChildScrollView(
          child: Container(
            height: api.deviceHeight(context),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.grey, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight)),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: api.deviceHeight(context) * 0.26,
                      child: FadeInImage(
                          placeholder: const AssetImage(appLogo),
                          image: AssetImage("assets/${rcLM.imgRsc}")),
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
                                        kpiOneV: rcLM.rcName,
                                        kpiTwoV: "\$ ${rcLM.rcPrice}",
                                        kpiThreeH: rcLM.rcImpact.name),
                                    const Gap(csGap),
                                    const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 8),
                                        child: ShopCardWidget()),
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
                          const Positioned(
                            right: 5,
                            child: CircleAvatar(
                              radius: 17,
                              child: Icon(Icons.star),
                            ),
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
        ),
      ),
    );
  }
}
