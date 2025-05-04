import 'package:flutter/material.dart';
import 'package:wcycle_bd/model/store_model.dart';
import 'package:wcycle_bd/widgets/store_page/store_profile_intro.dart';
import 'package:wcycle_bd/widgets/store_page/store_profile_tabview.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key, required this.shopModel});
  final StoreModel shopModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StoreProfileIntro(storeModel: shopModel),
          StoreProfileTabview(
            storeId: shopModel.id,
          )
        ],
      ),
    );
  }
}
