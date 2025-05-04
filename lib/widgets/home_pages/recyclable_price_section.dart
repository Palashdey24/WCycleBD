import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:wcycle_bd/data/model/remote/recycle_product_model.dart';
import 'package:wcycle_bd/screen/ui_view/recycable_product_list_ui.dart';
import 'package:wcycle_bd/screen/ui_view/shimmer/recycle_shimmer.dart';
import 'package:wcycle_bd/widgets/home_pages/recyclable_list_item.dart';
import 'package:wcycle_bd/widgets/home_pages/section_top_bar.dart';

class RecyclablePriceSection extends StatelessWidget {
  const RecyclablePriceSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<RecycleProductModel> recycleDataList = [];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionTopBar(
            stTxt: "Recyclable Product",
            onMore: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RecycableProductListUi(recycableList: recycleDataList),
                  ));
            }),
        SizedBox(
          height: 150,
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("recycleProduct")
                .where('productOnline', isEqualTo: false)
                .get(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const SizedBox(
                    height: 150,
                    child: RecycleShimmer(),
                  );

                case ConnectionState.active:
                case ConnectionState.done:
                  final recycleData = snapshot.data!.docs;
                  //Add data to model list one after one
                  recycleDataList = recycleData
                      .map(
                        (e) => RecycleProductModel.fromJson(e.data(), e.id),
                      )
                      .toList();
              }
              return SizedBox(
                height: 150,
                child: recycleDataList.isEmpty
                    ? const LoadingIndicator(
                        indicatorType: Indicator.ballRotate)
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recycleDataList.length,
                        itemBuilder: (context, index) {
                          return RecyclableListItem(
                            rcListModel: recycleDataList[index],
                            isDtPage: false,
                          );
                        },
                      ),
              );
            },
          ),
        ),
      ],
    );
  }
}
