import 'package:flutter/material.dart';

class ReuseableContainer extends StatelessWidget {
  const ReuseableContainer(
      {super.key,
      required this.ctColor,
      required this.ctMargin,
      this.ctWidget});

  final Color ctColor;
  final EdgeInsetsGeometry ctMargin;
  final Widget? ctWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      margin: ctMargin,
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: Colors.blueGrey, blurRadius: 5)],
        color: ctColor,
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(30),
        ),
      ),
      child: ctWidget,
    );
  }
}
