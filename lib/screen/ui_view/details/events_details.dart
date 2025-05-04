import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/event_model.dart';
import 'package:wcycle_bd/provider/user_fs_provider.dart';
import 'package:wcycle_bd/screen/ui_view/details/events_details/buttons_widget_events.dart';
import 'package:wcycle_bd/screen/ui_view/details/events_details/organizer_card_widget.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/box_info_ui.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/details_frame_one.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/details_ui_kpi.dart';

final fontHelpers = FontHelper();

class EventsDetails extends ConsumerWidget {
  const EventsDetails({super.key, required this.eventData});

  final EventModel eventData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userFSProvider);
    return Scaffold(
      body: DetailsFrameOne(
          infoSections: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: normalGap,
            children: [
              DetailsUiKpi(
                kpiOneV: eventData.eventsTittle!,
                kpiTwoV: eventData.litteredAddress!,
                kpiThreeH: eventData.eventsInterested.toString(),
                kpiTVIcons: FontAwesomeIcons.addressBook,
                kpiThVIcons: Icons.favorite,
              ),
              if (user.individual == true) const ButtonsWidgetEvents(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BoxInfoUI(text1: eventData.eventsDate!, text2: "Date"),
                  BoxInfoUI(text1: eventData.eventsTime!, text2: "Time"),
                ],
              ),
              Text(
                eventData.eventsDescription!,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Colors.grey,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              OrganizerCardWidget(eventData.userId!),
              Text(
                "Recommendation",
                style: fontHelpers.bodyMedium(context),
              ),
            ],
          ),
          stackImage: eventData.ltSrc!),
    );
  }
}
