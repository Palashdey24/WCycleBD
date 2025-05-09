import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/littered_model.dart';
import 'package:wcycle_bd/pages/add/add_littered_spot_items.dart';
import 'package:wcycle_bd/pages/add/create_event.dart';
import 'package:wcycle_bd/provider/current_user_fs_provider.dart';
import 'package:wcycle_bd/screen/ui_view/details/littered_details/bottom_floating_widget_lt.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/details_frame_one.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/details_ui_kpi.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/waste_material_chips.dart';

final fontHelpers = FontHelper();

class LitteredSpotDetails extends ConsumerWidget {
  const LitteredSpotDetails({super.key, required this.ltData});

  final LitteredModel ltData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(currentUserdataProvider);
    final fullAddress =
        "${ltData.litteredAddress},${ltData.litteredWard}, ${ltData.litteredVillMet}, ${ltData.litteredThana}, ${ltData.litteredDivision},";
    return Scaffold(
      floatingActionButton: user.individual != false
          ? FloatingActionButton(
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddLitteredSpotItems(),
                  )),
              child: const Icon(Icons.add_circle),
            )
          : null,
      body: DetailsFrameOne(
          infoSections: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: normalGap,
            children: [
              DetailsUiKpi(
                  kpiOneV: ltData.litteredTittle,
                  kpiTwoV: fullAddress,
                  kpiTVIcons: FontAwesomeIcons.addressBook,
                  kpiThreeH: ltData.litteredImpactLevel),
              WasteMaterialChips(ltWCat: ltData.litteredWasteMat),
              Text(
                "Recommendation",
                style: fontHelpers.bodyMedium(context),
              ),
            ],
          ),
          bottomPosWidgets: user.individual == false
              ? BottomFloatingWidgetLt(
                  onCreateEvent: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateEventsItem(
                        litteredModel: ltData,
                      ),
                    ),
                  ),
                )
              : null,
          stackImage: ltData.ltSrc),
    );
  }
}
