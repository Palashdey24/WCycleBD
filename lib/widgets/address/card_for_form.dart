import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/pre_style.dart';

class CardForForm extends StatelessWidget {
  const CardForForm(
      {super.key, required this.cardWidgets, required this.title});
  final List<Widget> cardWidgets;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
        child: Flex(
          direction: Axis.vertical,
          spacing: normalGap,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            const Gap(5),
            ...cardWidgets,
          ],
        ),
      ),
    );
  }
}
