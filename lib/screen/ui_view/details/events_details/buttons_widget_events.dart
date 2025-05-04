import 'package:flutter/material.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/pages/add/add_littered_spot_items.dart';

class ButtonsWidgetEvents extends StatelessWidget {
  const ButtonsWidgetEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: normalGap,
        children: [
          Expanded(
            child: ElevatedButton(
                onPressed: () {}, child: const Text("Interested")),
          ),
          Expanded(
            child: ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddLitteredSpotItems(),
                    )),
                child: const Text("Donate")),
          ),
        ],
      ),
    );
  }
}
