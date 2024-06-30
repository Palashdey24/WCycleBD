import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wcycle_bd/model/littered_list_model.dart';
import 'package:wcycle_bd/utilts/global_value.dart';

class LitteredListItemInfo extends StatelessWidget {
  const LitteredListItemInfo({super.key, required this.ltList});

  final LitteredListModel ltList;

  @override
  Widget build(BuildContext context) {
    String? combainWcat;
    for (final wcat in ltList.ltWCat) {
      if (combainWcat == null) {
        combainWcat = wcat;
      } else {
        combainWcat = "$combainWcat-$wcat";
      }
    }

    final themes = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            ltList.ltTittle,
            style: themes.titleSmall!.copyWith(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(5),
          Row(
            children: [
              const Icon(
                Icons.place,
                color: Colors.blueGrey,
              ),
              Flexible(
                child: Text(
                  textAlign: TextAlign.right,
                  maxLines: 5,
                  softWrap: true,
                  "${ltList.villMetro}, ${ltList.thana}, ${ltList.division}",
                  style: GoogleFonts.lato(
                      fontSize: 8, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Gap(5),
          Flexible(
            child: Text(
              "Type: $combainWcat ",
              maxLines: 4,
              textAlign: TextAlign.right,
              style: const TextStyle(
                  color: Color.fromARGB(202, 133, 139, 18),
                  fontSize: 8,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Gap(5),
          Text(
            "Level: ${ltList.ltLevel.name}",
            style: themes.titleSmall!.copyWith(color: kDefaultColor),
          ),
        ],
      ),
    );
  }
}
