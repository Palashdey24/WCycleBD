import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';

final fontHelper = FontHelper();

class ProfilePageKpiData extends StatelessWidget {
  const ProfilePageKpiData(
      {super.key,
      required this.tittle,
      required this.kpiName,
      required this.iconData,
      required this.iconColor});

  final String tittle;
  final String kpiName;
  final IconData iconData;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(normalGap),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey, width: 0.5),
              right: BorderSide(color: Colors.grey, width: 0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            tittle,
            style: fontHelper.bodyMedium(context).copyWith(color: Colors.white),
          ),
          const Gap(5),
          Icon(
            iconData,
            size: 30,
            color: iconColor,
          ),
          const Gap(csGap),
          Text(
            kpiName,
            textAlign: TextAlign.center,
            style: fontHelper.bodySmall(context).copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }
}
