import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/event_model.dart';
import 'package:wcycle_bd/pages/add/add_events_items.dart';
import 'package:wcycle_bd/provider/current_user_fs_provider.dart';
import 'package:wcycle_bd/widgets/home_pages/events_list_item.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/search_box.dart';

class EventsListUi extends ConsumerWidget {
  const EventsListUi({super.key, required this.eventsList});

  final List<EventModel> eventsList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserdataProvider);
    return Scaffold(
      floatingActionButton: user.individual == false
          ? FloatingActionButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddEventsItems(),
                  )),
              child: const Icon(Icons.add_circle),
            )
          : null,
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
                      eventsModel: eventsList[index],
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
