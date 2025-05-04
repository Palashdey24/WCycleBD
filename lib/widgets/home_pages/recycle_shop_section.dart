import 'package:flutter/material.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/model/store_model.dart';
import 'package:wcycle_bd/screen/ui_view/shimmer/lt_shimmer.dart';
import 'package:wcycle_bd/screen/ui_view/shop_list_ui.dart';
import 'package:wcycle_bd/widgets/home_pages/section_top_bar.dart';
import 'package:wcycle_bd/widgets/home_pages/shop_list_item.dart';

final apis = Apis();

class RecycleShopSection extends StatelessWidget {
  const RecycleShopSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<StoreModel> shopModel = [];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionTopBar(
            stTxt: "Recycle Shop",
            onMore: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShopListUi(shopModel: shopModel),
                ))),
        SizedBox(
          height: 160,
          child: FutureBuilder(
              future: apis.fireStore.collection('store').get(),
              builder: (BuildContext context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const SizedBox(
                      height: 300,
                      child: LtShimmer(),
                    );

                  case ConnectionState.active:
                  case ConnectionState.done:
                    final datas = snapshot.data!.docs;

/*                    final encodeData =
                        jsonEncode(snapshot.data!.docs[0].data());
                    log(encodeData);*/

                    //Add data to model list one after one
                    shopModel = datas
                        .map(
                          (e) => StoreModel.fromJson(e.data()),
                        )
                        .toList();
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: shopModel.length,
                  itemBuilder: (context, index) {
                    return ShopListItem(
                      shopModel: shopModel[index],
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}
