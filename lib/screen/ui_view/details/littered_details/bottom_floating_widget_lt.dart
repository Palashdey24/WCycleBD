import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/pre_style.dart';

class BottomFloatingWidgetLt extends StatelessWidget {
  const BottomFloatingWidgetLt({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
                onPressed: () {}, child: const Text("Create Event")),
          ),
          const Gap(normalGap),
          Expanded(
            child: ElevatedButton(
                onPressed: () {}, child: const Text("Take Initiative")),
          ),
        ],
      ),
    );
  }
}
