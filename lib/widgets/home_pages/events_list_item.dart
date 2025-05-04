import 'package:flutter/material.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/model/event_model.dart';
import 'package:wcycle_bd/screen/ui_view/details/events_details.dart';
import 'package:wcycle_bd/widgets/home_pages/even_date_show.dart';
import 'package:wcycle_bd/widgets/home_pages/events_list_item_info.dart';

final apis = Apis();

class EventsListItem extends StatelessWidget {
  const EventsListItem({super.key, this.isVertical, required this.eventsModel});

  final EventModel eventsModel;
  final bool? isVertical;

  @override
  Widget build(BuildContext context) {
    String eventsDate = eventsModel.eventsDate!.trim();
    String year = eventsDate.substring(eventsDate.lastIndexOf(" ") + 1);
    List<String> splitted = eventsDate.split(",");
    List<String> dayMonth = splitted[1].split(" ");

    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventsDetails(eventData: eventsModel),
          )),
      child: Stack(
        children: [
          Container(
              margin: const EdgeInsets.only(left: 8, top: 5),
              clipBehavior: Clip.hardEdge,
              width: isVertical != null
                  ? (apis.deviceWidth(context) / 1)
                  : (apis.deviceWidth(context) / 1.7),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.10),
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
                ],
              )),
        ],
      ),
    );
  }
}
