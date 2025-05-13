import 'package:flutter/material.dart';
import 'package:wcycle_bd/model/store_model.dart';
import 'package:wcycle_bd/pages/store_page.dart';
import 'package:wcycle_bd/widgets/home_pages/shop_list_item_info.dart';

class ShopListItem extends StatelessWidget {
  const ShopListItem({super.key, required this.shopModel});
  final StoreModel shopModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StorePage(
              shopModel: shopModel,
            ),
          )),
      child: Container(
        width: 150,
        height: 150,
        margin: const EdgeInsets.only(left: 20, top: 20),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.blueGrey.withValues(alpha: 0.8),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),
        child: ShopListItemInfo(
          shopModel: shopModel,
        ),
      ),
    );
  }
}
