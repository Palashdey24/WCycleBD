import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/card_with_outlined.dart';

class ShopCardWidget extends StatelessWidget {
  const ShopCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: CardWithOutlined(
          cardWidget: Flex(
        mainAxisAlignment: MainAxisAlignment.center,
        direction: Axis.horizontal,
        children: [
          const Expanded(
            flex: 30,
            child: CircleAvatar(
              radius: 35,
              foregroundImage: AssetImage("assets/PersonAvater.png"),
            ),
          ),
          Expanded(
              flex: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(5),
                  const Text(
                    "Shop Name",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white),
                  ),
                  const Gap(5),
                  Text(
                    "Address: Near Megha Community Center, Chakrashala",
                    style:
                        TextStyle(fontSize: 12, color: Colors.yellow.shade100),
                  ),
                  const Gap(5),
                  const Row(
                    children: [
                      FaIcon(
                          size: 15,
                          color: Colors.red,
                          FontAwesomeIcons.solidStar),
                      Gap(5),
                      Text(
                        "4.5/100",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      )),
    );
  }
}
