import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wcycle_bd/widgets/home_pages/recyclable_list_item.dart';


class RecycleShimmer extends StatelessWidget {
  const RecycleShimmer({super.key, this.isVertical});

  final bool? isVertical;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            for (int a = 1; a <= 5; a++) const RecyclableListItem(),
          ],
        ));
  }
}
