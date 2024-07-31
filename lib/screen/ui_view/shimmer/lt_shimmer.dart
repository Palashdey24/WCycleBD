import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LtShimmer extends StatelessWidget {
  const LtShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: const Text("data"));
  }
}
