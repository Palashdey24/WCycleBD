import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingWidgets extends StatelessWidget {
  const LoadingWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoadingIndicator(
        indicatorType: Indicator.ballSpinFadeLoader,
        colors: [
          Colors.white,
          Colors.green,
          Colors.red,
          Colors.yellow,
          Colors.orange
        ],
        strokeWidth: 1,
        backgroundColor: Colors.transparent,
        pathBackgroundColor: Colors.orange);
  }
}
