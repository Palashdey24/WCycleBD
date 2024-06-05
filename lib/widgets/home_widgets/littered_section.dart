import 'package:flutter/material.dart';
import 'package:wcycle_bd/data/littered_list_data.dart';
import 'package:wcycle_bd/widgets/home_widgets/littered_list_item.dart';
import 'package:wcycle_bd/widgets/home_widgets/section_top_bar.dart';

class LitteredSpotSection extends StatelessWidget {
  const LitteredSpotSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionTopBar(stTxt: "Littered Spot", onMore: () {}),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: litteredListData.length,
            itemBuilder: (context, index) {
              return LitteredListItem(ltListModel: litteredListData[index]);
            },
          ),
        ),
      ],
    );
  }
}
