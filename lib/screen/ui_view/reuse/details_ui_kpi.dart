import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/utilts/colors.dart';

final fontHelpers = FontHelper();

class DetailsUiKpi extends StatelessWidget {
  const DetailsUiKpi(
      {super.key,
      required this.kpiOneV,
      required this.kpiTwoV,
      required this.kpiThreeH,
      this.kpiTVIcons,
      this.kpiThVIcons});
  final String kpiOneV;
  final String kpiTwoV;
  final IconData? kpiTVIcons;
  final String kpiThreeH;
  final IconData? kpiThVIcons;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 60,
                child: Text(
                  kpiOneV,
                  style: fontHelpers.bodyMedium(context).copyWith(),
                ),
              ),
              Expanded(
                flex: 40,
                child: kpiThVIcons == null
                    ? Text(
                        textAlign: TextAlign.right,
                        kpiThreeH.toUpperCase(),
                        style: fontHelpers.bodyMedium(context).copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FaIcon(
                            kpiThVIcons,
                            size: 20,
                            color: Colors.blue,
                          ),
                          const Gap(5),
                          Text(
                            kpiThreeH.toUpperCase(),
                            style: fontHelpers
                                .bodyMedium(context)
                                .copyWith(color: Colors.blueAccent),
                          ),
                        ],
                      ),
              ),
            ],
          ),
          const Gap(normalGap),
          if (kpiTVIcons != null)
            ListTile(
              leading: FaIcon(
                kpiTVIcons,
                size: 20,
                color: kDefaultColor,
              ),
              title: Text(
                kpiTwoV,
                style: fontHelpers.bodyMedium(context).copyWith(
                      color: Colors.blue,
                    ),
              ),
            ),
          if (kpiTVIcons == null)
            Text(
              kpiTwoV,
              style: fontHelpers
                  .bodyMedium(context)
                  .copyWith(color: Colors.blueAccent),
            ),
        ],
      ),
    );
  }
}
