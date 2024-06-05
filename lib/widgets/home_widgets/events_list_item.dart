import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/model/littered_list_model.dart';
import 'package:wcycle_bd/widgets/home_widgets/even_date_show.dart';
import 'package:wcycle_bd/widgets/home_widgets/events_list_item_info.dart';
import 'package:wcycle_bd/widgets/home_widgets/littered_list_item_info.dart';

class EventsListItem extends StatelessWidget {
  const EventsListItem({super.key, required this.ltListModel});

  final LitteredListModel ltListModel;

  @override
  Widget build(BuildContext context) {
    final srcWidth = MediaQuery.sizeOf(context).width;
    return Stack(
      children: [
        Container(
            margin: const EdgeInsets.only(left: 8, top: 5),
            clipBehavior: Clip.hardEdge,
            width: srcWidth / 1.7,
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
    );
  }
}
