import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/littered_list_model.dart';
import 'package:wcycle_bd/screen/ui_view/details/events_details/bottom_floating_widget_events.dart';
import 'package:wcycle_bd/screen/ui_view/details/recycable_details/shop_card_widget.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/box_info_ui.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/details_frame_one.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/details_ui_kpi.dart';

final fontHelpers = FontHelper();

class EventsDetails extends StatelessWidget {
  const EventsDetails({super.key, required this.ltData});

  final LitteredListModel ltData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DetailsFrameOne(
          infoSections: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(normalGap),
              DetailsUiKpi(
                kpiOneV: ltData.ltTittle,
                kpiTwoV: ltData.address,
                kpiThreeH: " 5",
                kpiTVIcons: FontAwesomeIcons.addressBook,
                kpiThVIcons: Icons.favorite,
              ),
              const Gap(normalGap),
              const Divider(),
              const Row(
                children: [
                  BoxInfoUI(text1: "21 Aug 2014", text2: "Date"),
                  BoxInfoUI(text1: "9 Am", text2: "Time"),
                ],
              ),
              const Gap(csGap),
              const Text(
                'Lorem ipsum is simply dummy text of printing & typesetting industry, Lorem ipsum is simply dummy text of printing & typesetting industry.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Colors.grey,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(csGap),
              const ShopCardWidget(),
              const Gap(normalGap),
              Text(
                "Recommendation",
                style: fontHelpers.bodyMedium(context),
              ),
              const Gap(normalGap),
            ],
          ),
          bottomPosWidgets: const BottomFloatingWidgetevents(),
          stackImage: ltData.ltSrc),
    );
  }
}
