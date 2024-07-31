import 'package:flutter/material.dart';
import 'package:wcycle_bd/data/littered_list_data.dart';
import 'package:wcycle_bd/screen/ui_view/events_list_ui.dart';
import 'package:wcycle_bd/widgets/home_pages/events_list_item.dart';
import 'package:wcycle_bd/widgets/home_pages/section_top_bar.dart';

class EventSection extends StatelessWidget {
  const EventSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionTopBar(
            stTxt: "Events",
            onMore: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventsListUi(
                    eventsList: litteredListData,
                  ),
                ))),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: litteredListData.length,
            itemBuilder: (context, index) {
              return EventsListItem(ltListModel: litteredListData[index]);
            },
          ),
        ),
      ],
    );
  }
}
