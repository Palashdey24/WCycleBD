import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:wcycle_bd/helper/firebase_helper.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/model/event_model.dart';
import 'package:wcycle_bd/provider/current_user_fs_provider.dart';
import 'package:wcycle_bd/screen/ui_view/events_list_ui.dart';
import 'package:wcycle_bd/screen/ui_view/shimmer/lt_shimmer.dart';
import 'package:wcycle_bd/widgets/home_pages/events_list_item.dart';
import 'package:wcycle_bd/widgets/home_pages/section_top_bar.dart';

class EventSection extends ConsumerWidget {
  const EventSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Stream<QuerySnapshot<Map<String, dynamic>>> futureSnap =
        FirebaseHelper.fireStore.collection('events').snapshots();
    Stream<QuerySnapshot<Map<String, dynamic>>> futureOrganSnap = FirebaseHelper
        .fireStore
        .collection('events')
        .where("userId",
            isEqualTo: FirebaseHelper.firebaseAuth.currentUser!.uid)
        .snapshots();
    List<EventModel> eventListData = [];
    final user = ref.read(currentUserdataProvider);

    List<EventModel> eventFn(List<EventModel> data) {
      if (user.individual == false) {
        return data;
      }
      return data.where(
        (element) {
          final now = DateTime.now();
          final eventTime =
              DateFormat('yMMMEd').parse(element.eventsDate!.trim());
          final isExpired = eventTime.isBefore(now);
          return !isExpired;
        },
      ).toList();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionTopBar(
            stTxt: "Events",
            onMore: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventsListUi(
                    eventsList: eventListData,
                  ),
                ))),
        SizedBox(
          height: 200,
          child: StreamBuilder(
              stream: user.individual == true ? futureSnap : futureOrganSnap,
              builder: (BuildContext context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const SizedBox(
                      height: 300,
                      child: LtShimmer(),
                    );

                  case ConnectionState.active:
                  case ConnectionState.done:
                    final datas = snapshot.data!.docs;

                    //Add data to model list one after one

                    final data = datas
                        .map(
                          (e) => EventModel.fromJson(e.data()),
                        )
                        .toList();

                    eventListData = eventFn(data);
                }

                return eventListData.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: eventListData.length,
                        itemBuilder: (context, index) {
                          return EventsListItem(
                              eventsModel: eventListData[index]);
                        },
                      )
                    : Center(
                        child: Text(
                          "No Events Found",
                          style: FontHelper().bodyMedium(context),
                        ),
                      );
              }),
        ),
      ],
    );
  }
}
