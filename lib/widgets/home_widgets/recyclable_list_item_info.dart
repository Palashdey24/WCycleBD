import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/model/recyclable_list_model.dart';
import 'package:wcycle_bd/utilts/variable.dart';

class RecyclableListItemInfo extends StatelessWidget {
  const RecyclableListItemInfo({super.key, required this.rcListModel});

  final RecyclableListModel rcListModel;

  @override
  Widget build(BuildContext context) {
    final themes = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              textAlign: TextAlign.center,
              rcListModel.rcName,
              style: themes.labelLarge!
                  .copyWith(color: kDefaultColor, fontWeight: FontWeight.bold),
            ),
            const Gap(5),
            Text(
              textAlign: TextAlign.center,
              "Level: ${rcListModel.rcImpact.name}",
              maxLines: 2,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            const Gap(10),
          ],
        ),
        Container(
          width: 45,
          decoration: const BoxDecoration(
              color: Color.fromARGB(208, 4, 13, 5),
              borderRadius: BorderRadius.only(topRight: Radius.circular(10))),
          child: Text(
            textAlign: TextAlign.left,
            "\$${rcListModel.rcPrice.toString()}",
            style: themes.labelMedium!.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
