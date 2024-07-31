import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/model/littered_list_model.dart';
import 'package:wcycle_bd/screen/ui_view/details/events_details.dart';
import 'package:wcycle_bd/widgets/home_pages/even_date_show.dart';
import 'package:wcycle_bd/widgets/home_pages/events_list_item_info.dart';

final apis = Apis();

class EventsListItem extends StatelessWidget {
  const EventsListItem({super.key, required this.ltListModel, this.isVertical});

  final LitteredListModel ltListModel;
  final bool? isVertical;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventsDetails(ltData: ltListModel),
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
              child: EventsListItemInfo(ltList: ltListModel)),
          const Positioned(
              top: 0,
              left: 20,
              child: Row(
                children: [
                  EvenDateShow(dmyTxt: "05"),
                  Gap(2),
                  EvenDateShow(dmyTxt: "Dec"),
                  Gap(2),
                  EvenDateShow(dmyTxt: "24"),
                ],
              )),
        ],
      ),
    );
  }
}
