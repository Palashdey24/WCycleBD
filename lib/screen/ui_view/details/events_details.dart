import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd/helper/device_size.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
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

  static void showInterestDialog(
    BuildContext context,
    List<Users> interestedUsersList,
  ) {
    if (interestedUsersList.isEmpty) {
      DialogsHelper.showMessage(context, "No User Interested");
      return;
    }

    showBottomSheet(
      context: context,
      constraints:
          BoxConstraints(maxHeight: DeviceSize.getDeviceHeight(context) * 0.7),
      backgroundColor: Colors.black.withValues(alpha: 0.8),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
      builder: (context) {
        return Stack(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 3 / 2,
              ),
              itemCount: interestedUsersList.length,
              padding: const EdgeInsets.only(bottom: 5, top: 50),
              itemBuilder: (context, index) => EventInterestUserUi(
                user: interestedUsersList[index],
              ),
            ),
            Positioned(
              top: 15,
              left: 15,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const FaIcon(
                  FontAwesomeIcons.circleXmark,
                  color: Colors.red,
                  size: 25,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Users> interestedUsersList = [];
    final user = ref.read(currentUserdataProvider);
    final usersData = ref.read(usersFsProviders);

    return Scaffold(
      body: SafeArea(
        child: DetailsFrameOne(
            infoSections: Consumer(
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: normalGap,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BoxInfoUI(text1: eventData.eventsDate!, text2: "Date"),
                        BoxInfoUI(text1: eventData.eventsTime!, text2: "Time"),
                      ],
                    ),

                    Text(
                      "Events Plan",
                      style: FontHelper()
                          .bodyMedium(context)
                          .copyWith(color: Colors.lightBlue),
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
                  ],
                ),
                builder: (context, ref, child) {
                  final interestData = ref.watch(eventInterestUserProvider);

                  log("interestData: ${interestData.interestedUsers?.length}");

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
                      child!,
                      Flex(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        direction: Axis.horizontal,
                        children: [
                          Text(
                            "User Interested",
                            style: fontHelpers.bodyMedium(context),
                          ),
                          TextButton(
                              onPressed: () => showInterestDialog(
                                  context, interestedUsersList),
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
                          : SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: interestedUsersList.length < 10
                                    ? interestedUsersList.length
                                    : interestedUsersList.sublist(0, 10).length,
                                padding: const EdgeInsets.only(bottom: 5),
                                itemBuilder: (context, index) =>
                                    EventInterestUserUi(
                                  user: interestedUsersList[index],
                                  colors:
                                      Colors.blueGrey.withValues(alpha: 0.1),
                                ),
                              ),
                            )
                    ],
                  );
                }),
            stackImage: eventData.ltSrc!),
      ),
    );
  }
}
