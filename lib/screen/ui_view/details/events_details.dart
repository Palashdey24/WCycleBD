import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/event_model.dart';
import 'package:wcycle_bd/model/users.dart';
import 'package:wcycle_bd/provider/current_user_fs_provider.dart';
import 'package:wcycle_bd/provider/event_interest_data_provider.dart';
import 'package:wcycle_bd/provider/users_fs_provider.dart';
import 'package:wcycle_bd/screen/ui_view/details/events_details/buttons_widget_events.dart';
import 'package:wcycle_bd/screen/ui_view/details/events_details/event_interest_user_ui.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/box_info_ui.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/details_frame_one.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/details_ui_kpi.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/info_card_widget.dart';

final fontHelpers = FontHelper();

class EventsDetails extends ConsumerWidget {
  const EventsDetails({super.key, required this.eventData});

  final EventModel eventData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(currentUserdataProvider);
    return Scaffold(
      body: DetailsFrameOne(
          infoSections: Consumer(builder: (context, ref, child) {
            final interestData = ref.watch(eventInterestUserProvider);
            List<Users> interestedUsersList = [];

            final usersData = ref.read(usersFsProviders);

            if (interestData.interestedUsers != null) {
              final interestedUsersID = interestData!.interestedUsers!;

              for (var users in usersData) {
                if (interestedUsersID.contains(users.userId)) {
                  interestedUsersList.add(users);
                }
              }
            }

            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: normalGap,
              children: [
                DetailsUiKpi(
                  kpiOneV: eventData.eventsTittle!,
                  kpiTwoV: eventData.litteredAddress!,
                  kpiThreeH: interestData.eventsInterested.toString(),
                  kpiTVIcons: FontAwesomeIcons.addressBook,
                  kpiThVIcons: FontAwesomeIcons.circleNodes,
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
                //OrganizerCardWidget(eventData.userId!),
                InfoCardWidget(
                  dataId: eventData.userId!,
                  isEvent: true,
                ),
                Flex(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  direction: Axis.horizontal,
                  children: [
                    Text(
                      "User Interested",
                      style: fontHelpers.bodyMedium(context),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text("See All",
                            style: fontHelpers
                                .bodyMedium(context)
                                .copyWith(color: Colors.orange)))
                  ],
                ),
                interestedUsersList.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: csGap),
                        child: Center(
                          child: Text(
                            "No User Interested",
                            textAlign: TextAlign.center,
                            style: FontHelper()
                                .bodyMedium(context)
                                .copyWith(color: Colors.redAccent),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: interestedUsersList.length < 10
                              ? interestedUsersList.length
                              : interestedUsersList.sublist(0, 10).length,
                          padding: const EdgeInsets.only(bottom: 5),
                          itemBuilder: (context, index) => EventInterestUserUi(
                            imageUrl: interestedUsersList[index].imgUri,
                            userName: interestedUsersList[index].userName,
                          ),
                        ),
                      )
              ],
            );
          }),
          stackImage: eventData.ltSrc!),
    );
  }
}
