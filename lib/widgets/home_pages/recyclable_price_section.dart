import 'package:flutter/material.dart';
import 'package:wcycle_bd/data/recycable_price_data.dart';
import 'package:wcycle_bd/screen/ui_view/recycable_product_list_ui.dart';
import 'package:wcycle_bd/widgets/home_pages/recyclable_list_item.dart';
import 'package:wcycle_bd/widgets/home_pages/section_top_bar.dart';

class RecyclablePriceSection extends StatelessWidget {
  const RecyclablePriceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionTopBar(
            stTxt: "Recyclable Product",
            onMore: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RecycableProductListUi(recycableList: recyclable),
                  ));
            }),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recyclable.length,
            itemBuilder: (context, index) {
              return RecyclableListItem(rcListModel: recyclable[index],isDtPage: false,);
            },
          ),
        ),
      ],
    );
  }
}
