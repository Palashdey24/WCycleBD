import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wcycle_bd/api/apis.dart';

final apis = Apis();

class LtShimmer extends StatelessWidget {
  const LtShimmer({super.key, this.isVertical});

  final bool? isVertical;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: Stack(
          children: [
            SizedBox(
              width: isVertical != null
                  ? (apis.deviceWidth(context) / 1)
                  : (apis.deviceWidth(context) / 2),
              height: 140,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 8, top: 5),
                    clipBehavior: Clip.hardEdge,
                    width: isVertical != null
                        ? (apis.deviceWidth(context) / 1.10)
                        : apis.deviceWidth(context) / 2.5,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.10),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 5,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(5), right: Radius.circular(40)),
                      child: Container(
                        color: Colors.grey,
                        height: 100,
                        width: apis.deviceWidth(context) / 5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
