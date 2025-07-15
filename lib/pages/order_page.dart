import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/device_size.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/model/order_model.dart';
import 'package:wcycle_bd/provider/store_fs_data.dart';
import 'package:wcycle_bd/screen/ui_view/shimmer/lt_shimmer.dart';
import 'package:wcycle_bd/widgets/order/order_list_item.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/back_custom_button.dart';

class OrderPage extends ConsumerWidget {
  const OrderPage({super.key});

  static const List<String> StatusList = <String>[
    'All',
    'Placed',
    'Processing',
    'Out to take',
    'To Pay',
    'Paid',
    'Cancelled',
    'Pending',
    'Completed',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeData = ref.read(storeFsDataProvider);
    List<OrderModel> orders = [];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flex(
              direction: Axis.horizontal,
              spacing: 10,
              children: [
                const BackCustomButton(),
                Text(
                  "Orders",
                  style: FontHelper()
                      .bodyMedium(context)
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              width: DeviceSize.getDeviceWidth(context),
              height: 60,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                for (var status in StatusList)
                  TextButton(onPressed: () {}, child: Text(status)),
              ]),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0),
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(40),
                    right: Radius.circular(40),
                  ),
                ),
                child: StreamBuilder(
                    stream:
                        Apis().fireStore.collection("recycleOrder").snapshots(),
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

                          //Add data to model list one after one
                          orders = datas
                              .map(
                                (e) => OrderModel.fromJson(e.data(),
                                    orderID: e.id),
                              )
                              .toList();

/*
                          for (var inout in datas!) {
                            log(jsonEncode(inout.data()));
                          }*/
                      }

                      return orders.isNotEmpty
                          ? ListView.builder(
                              itemCount: orders.length,
                              itemBuilder: (context, index) {
                                final storeName = storeData
                                    .firstWhere(
                                      (element) =>
                                          element.id == orders[index].storeId,
                                    )
                                    .storeName;
                                return OrderListItem(
                                  order: orders[index],
                                  storeName: storeName,
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                "No Order Yet",
                                style: FontHelper().bodyLarge(context),
                              ),
                            );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
