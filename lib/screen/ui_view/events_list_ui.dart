import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/littered_list_model.dart';
import 'package:wcycle_bd/widgets/home_pages/events_list_item.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/search_box.dart';

class EventsListUi extends StatelessWidget {
  const EventsListUi({super.key, required this.eventsList});

  final List<LitteredListModel> eventsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SearchBox(),
            const Gap(csGap),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: eventsList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 8, bottom: 8),
                    child: EventsListItem(
                      ltListModel: eventsList[index],
                      isVertical: true,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
