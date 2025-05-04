import 'package:flutter/material.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/store_model.dart';
import 'package:wcycle_bd/screen/ui_view/item_view_frame.dart';
import 'package:wcycle_bd/widgets/home_pages/shop_list_item.dart';

final api = Apis();

class ShopListUi extends StatelessWidget {
  const ShopListUi({super.key, required this.shopModel});

  final List<StoreModel> shopModel;

  @override
  Widget build(BuildContext context) {
    return ItemViewFrame(
        viewType: Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(largeGap))),
      child: GridView.builder(
        itemCount: shopModel.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 240),
        itemBuilder: (context, index) {
          return ShopListItem(shopModel: shopModel[index]);
        },
      ),
    ));
  }
}
