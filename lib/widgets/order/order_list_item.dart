import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/model/order_model.dart';
import 'package:wcycle_bd/widgets/order/order_delivery_info_ui.dart';

import 'order_item_product_info.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({super.key, required this.order, this.storeName});

  final OrderModel order;
  final String? storeName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsetsGeometry.only(bottom: 20),
          child: Card(
            clipBehavior: Clip.hardEdge,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        storeName ?? "N/A",
                        style: FontHelper().bodyMedium(context),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey.withValues(alpha: 0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          order.status![order.status!.length - 1].status,
                          style: FontHelper().bodySmall(context),
                        ),
                      ),
                    ],
                  ),
                ),
                for (final product in order.products!)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OrderItemProductInfo(
                      products: product,
                    ),
                  ),
                const Divider(
                  color: Colors.green,
                  thickness: 3,
                ),
                const Gap(5),
                OrderDeliveryInfoUi(
                    uiTittle: "Date:",
                    uiData: order.status![order.status!.length - 1].Time),
                OrderDeliveryInfoUi(
                    uiTittle: "Total Payable:",
                    uiData: order.totalPrice!.toString()),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black)),
                    child: Text(
                        order.status![order.status!.length - 1].status !=
                                "Completed"
                            ? "Cancel Order"
                            : "Return/Refund",
                        style: FontHelper()
                            .bodySmall(context)
                            .copyWith(color: Colors.white)),
                  ),
                ),
                const Gap(25),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 10,
            child: Card(
              color: Colors.blueGrey,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "ID: ${order.orderID}",
                  textAlign: TextAlign.center,
                  style: FontHelper()
                      .bodyMedium(context)
                      .copyWith(color: Colors.white),
                ),
              ),
            ))
      ],
    );
  }
}
