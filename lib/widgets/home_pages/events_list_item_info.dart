import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wcycle_bd/model/littered_list_model.dart';

class EventsListItemInfo extends StatelessWidget {
  const EventsListItemInfo({super.key, required this.ltList});

  final LitteredListModel ltList;

  @override
  Widget build(BuildContext context) {
    final themes = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          ltList.ltSrc,
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
                ltList.ltTittle,
                style: themes.titleSmall!.copyWith(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(2),
              Text(
                textAlign: TextAlign.left,
                softWrap: true,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                "T size which gave the result i wanted. size which gave the result i wanted.There is no way to limit the number of objects, but what you can do iThere is no way to limit the number of objects, but what you can do is to put the gridview in a container and limit the size which gave the result i wanted.",
                style: GoogleFonts.lato(
                  fontSize: 8,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Interested: 5",
                    style: themes.labelSmall,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.blue,
                    ),
                    onPressed: () {},
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
