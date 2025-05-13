import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wcycle_bd/data/model/remote/recycle_product_model.dart';
import 'package:wcycle_bd/helper/device_size.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/screen/ui_view/shimmer/recycle_shimmer.dart';
import 'package:wcycle_bd/widgets/home_pages/recyclable_list_item.dart';

class StoreProfileTabview extends StatelessWidget {
  const StoreProfileTabview({super.key, required this.storeId});
  final String storeId;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> tabIndex = ValueNotifier(0);
    List<RecycleProductModel> storeRecycleList = [];

    Widget productSection() {
/*      void data() async {
         await FirebaseFirestore.instance
            .collection("checking")
            .doc(storeId)
            .get()
            .then(
          (value) {
            final storeData = value.data();
            if (!context.mounted) return;
            DialogsHelper.showMessage(
                context, storeData?['storeData'].toString() ?? "N/A");
          },
        );
      }*/

      return FutureBuilder(
        future: FirebaseFirestore.instance.collection("recycleProduct").get(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const SizedBox(
                height: 200,
                child: RecycleShimmer(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              final recycleData = snapshot.data!.docs;
              //Add data to model list one after one
              storeRecycleList = recycleData
                  .map(
                    (e) => RecycleProductModel.fromJson(e.data(), e.id),
                  )
                  .toList();

              final recycleFiltered = storeRecycleList.where(
                (element) {
                  return element.shopID == storeId;
                },
              ).toList();

              return recycleFiltered.isNotEmpty
                  ? GridView.builder(
                      padding: const EdgeInsets.all(0),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150),
                      itemCount: recycleFiltered.length,
                      itemBuilder: (context, index) {
                        return RecyclableListItem(
                          rcListModel: recycleFiltered[index],
                          isDtPage: false,
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "Store Not Add Product Yet",
                        style: FontHelper()
                            .bodyMedium(context)
                            .copyWith(color: Colors.red),
                      ),
                    );
          }
        },
      );
    }

    final List<Map<String, dynamic>> tabBarName = [
      {
        "tabName": "Product",
      },
      {
        "tabName": "Services",
      },
      {
        "tabName": "Rating",
      },
    ];

    List<Widget> tab = [
      productSection(),
      Center(
        child: Text(
          "Service feature available soon",
          style: FontHelper().bodyMedium(context),
        ),
      ),
      Center(
        child: Center(
          child: Text(
            "Rating feature available soon",
            style: FontHelper().bodyMedium(context),
          ),
        ),
      )
    ];

    return ValueListenableBuilder(
        valueListenable: tabIndex,
        builder: (context, value, child) {
          return Column(
            children: [
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: normalGap),
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.all(Radius.circular(csGap))),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (final tab in tabBarName)
                      GestureDetector(
                        onTap: () {
                          tabIndex.value = tabBarName.indexOf(tab);
                        },
                        child: Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.all(0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: normalGap, vertical: 5),
                            decoration: BoxDecoration(
                                color: tabBarName[tabIndex.value]['tabName'] ==
                                        tab['tabName']
                                    ? Colors.black
                                    : null,
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(csGap))),
                            child: Center(
                              child: Text(
                                tab["tabName"],
                                textAlign: TextAlign.center,
                                style:
                                    FontHelper().bodyMedium(context).copyWith(
                                          color: tabBarName[tabIndex.value]
                                                      ['tabName'] ==
                                                  tab['tabName']
                                              ? Colors.teal
                                              : Colors.white,
                                        ),
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(
                height: DeviceSize.getDeviceHeight(context) - 300,
                width: DeviceSize.getDeviceWidth(context),
                child: IndexedStack(
                  index: tabIndex.value,
                  children: tab,
                ),
              )
            ],
          );
        });
  }
}
