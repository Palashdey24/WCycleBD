import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/model/littered_model.dart';
import 'package:wcycle_bd/screen/ui_view/reuse/waste_material_chips.dart';
import 'package:wcycle_bd/utilts/colors.dart';

final fontHelper = FontHelper();

class LitteredListItemInfo extends StatelessWidget {
  const LitteredListItemInfo(
      {super.key, required this.ltList, this.isVertical});

  final LitteredModel ltList;
  final bool? isVertical;

  @override
  Widget build(BuildContext context) {
    String? combainWcat;
    for (final wcat in ltList.litteredWasteMat) {
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
            ltList.litteredTittle,
            style: themes.titleSmall!.copyWith(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
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
                  "${ltList.litteredVillMet}, ${ltList.litteredThana}, ${ltList.litteredDivision}",
                  style: GoogleFonts.lato(
                      fontSize: 8, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Gap(5),
          if (isVertical == null)
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
            "Level: ${ltList.litteredImpactLevel.toUpperCase()}",
            style: themes.titleSmall!.copyWith(color: kDefaultColor),
          ),
          const Gap(5),
          if (isVertical != null)
            WasteMaterialChips(ltWCat: ltList.litteredWasteMat),
        ],
      ),
    );
  }
}
