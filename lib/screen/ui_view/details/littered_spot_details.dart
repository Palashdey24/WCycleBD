import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/littered_model.dart';
import 'package:wcycle_bd/screen/ui_view/details/littered_details/bottom_floating_widget_lt.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/details_frame_one.dart';

import 'package:wcycle_bd/screen/ui_view/reuse/details_ui_kpi.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/waste_material_chips.dart';

final fontHelpers = FontHelper();

class LitteredSpotDetails extends StatelessWidget {
  const LitteredSpotDetails({super.key, required this.ltData});

  final LitteredModel ltData;

  @override
  Widget build(BuildContext context) {
    final fullAddress =
        "${ltData.litteredAddress},${ltData.litteredWard}, ${ltData.litteredVillMet}, ${ltData.litteredThana}, ${ltData.litteredDivision},";
    return Scaffold(
      body: DetailsFrameOne(
          infoSections: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(normalGap),
              DetailsUiKpi(
                  kpiOneV: ltData.litteredTittle,
                  kpiTwoV: fullAddress,
                  kpiTVIcons: FontAwesomeIcons.addressBook,
                  kpiThreeH: ltData.litteredImpactLevel),
              const Gap(normalGap),
              WasteMaterialChips(ltWCat: ltData.litteredWasteMat),
              const Gap(normalGap),
              Text(
                "Recommendation",
                style: fontHelpers.bodyMedium(context),
              ),
              const Gap(normalGap),
            ],
          ),
          bottomPosWidgets: const BottomFloatingWidgetLt(),
          stackImage: ltData.ltSrc),
    );
  }
}
