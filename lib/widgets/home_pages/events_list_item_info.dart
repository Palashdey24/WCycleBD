import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wcycle_bd/model/event_model.dart';

class EventsListItemInfo extends StatelessWidget {
  const EventsListItemInfo({super.key, required this.eventList});

  final EventModel eventList;

  @override
  Widget build(BuildContext context) {
    final themes = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          eventList.ltSrc!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 80,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 0, left: 8, right: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eventList.eventsTittle!,
                style: themes.titleSmall!.copyWith(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(2),
              Text(
                textAlign: TextAlign.left,
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                eventList.eventsDescription!,
                style: GoogleFonts.lato(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
              const Gap(2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    eventList.eventsInterested!.toString(),
                    style:
                        themes.labelSmall!.copyWith(color: Colors.deepOrange),
                  ),
                  const FaIcon(
                    size: 15,
                    FontAwesomeIcons.circleNodes,
                    color: Colors.blue,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
