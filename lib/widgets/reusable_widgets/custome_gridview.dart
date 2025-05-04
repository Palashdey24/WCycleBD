import 'package:flutter/material.dart';
import 'package:wcycle_bd/data/model/remote/recycle_product_model.dart';
import 'package:wcycle_bd/widgets/home_pages/recyclable_list_item.dart';

class CustomeGridview extends StatelessWidget {
  const CustomeGridview(
      {super.key,
      required this.rcList,
      required this.onTap,
      required this.isDtpage});

  final List<RecycleProductModel> rcList;
  final void Function(int index) onTap;
  final bool isDtpage;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: rcList.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150),
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () => onTap(index),
            child: RecyclableListItem(
              rcListModel: rcList[index],
              isDtPage: isDtpage,
            ));
      },
    );
  }
}
