import 'package:flutter/material.dart';
import 'package:wcycle_bd/helper/font_helper.dart';

class OrderDeliveryInfoUi extends StatelessWidget {
  const OrderDeliveryInfoUi(
      {super.key, required this.uiTittle, required this.uiData});

  final String uiTittle;
  final String uiData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            uiTittle,
            style: FontHelper().bodyMedium(context),
          ),
          Text(
            uiData,
            style: FontHelper().bodySmall(context),
          ),
        ],
      ),
    );
  }
}
