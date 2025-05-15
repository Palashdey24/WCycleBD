import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/model/event_model.dart';
import 'package:wcycle_bd/provider/current_user_fs_provider.dart';
import 'package:wcycle_bd/provider/event_interest_data_provider.dart';
import 'package:wcycle_bd/provider/indiviual_user_fs_provider.dart';
import 'package:wcycle_bd/screen/ui_view/details/events_details.dart';
import 'package:wcycle_bd/widgets/home_pages/even_date_show.dart';
import 'package:wcycle_bd/widgets/home_pages/events_list_item_info.dart';

final apis = Apis();

class EventsListItem extends ConsumerWidget {
  const EventsListItem({super.key, this.isVertical, required this.eventsModel});

  final EventModel eventsModel;
  final bool? isVertical;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String eventsDate = eventsModel.eventsDate!.trim();
    String year = eventsDate.substring(eventsDate.lastIndexOf(" ") + 1);
    List<String> splitted = eventsDate.split(",");
    List<String> dayMonth = splitted[1].split(" ");

    // ? This is for expired event check from eventDate

    final now = DateTime.now();
    final eventTime = DateFormat('yMMMEd').parse(eventsDate);
    final isExpired = eventTime.isBefore(now);

    final user = ref.read(currentUserdataProvider);

    return InkWell(
      onTap: () {
        DialogsHelper.showProgressBar(context);
        ref
            .read(individualUserdataProvider.notifier)
            .intiValue(eventsModel.userId!)
            .whenComplete(
          () {
            ref
                .read(eventInterestUserProvider.notifier)
                .eventInterestUserData(
                  eventsModel.eventsId!,
                )
                .then(
              (value) {
                if (!context.mounted) return;
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EventsDetails(eventData: eventsModel),
                    ));
              },
            );
          },
        );
      },
      child: Stack(
        children: [
          Container(
              constraints: const BoxConstraints(minHeight: 200),
              margin: const EdgeInsets.only(left: 8, top: 5),
              clipBehavior: Clip.hardEdge,
              width: isVertical != null
                  ? (apis.deviceWidth(context) / 1)
                  : (apis.deviceWidth(context) / 1.7),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.9),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: EventsListItemInfo(eventList: eventsModel)),
          Positioned(
              top: 0,
              left: 20,
              child: Row(
                spacing: 2,
                children: [
                  EvenDateShow(dmyTxt: dayMonth[2]),
                  EvenDateShow(dmyTxt: dayMonth[1]),
                  EvenDateShow(dmyTxt: year),
                  if (user.individual == false)
                    EvenDateShow(dmyTxt: isExpired ? "Expired" : "Active"),
                ],
              )),
        ],
      ),
    );
  }
}
