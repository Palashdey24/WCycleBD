import 'package:flutter/material.dart';

class NavIconItem extends StatelessWidget {
  const NavIconItem(
      {super.key,
      required this.curves,
      required this.navIcon,
      required this.navFn,
      required this.navIndex,
      required this.selIndex});

  final Curve curves;
  final int navIndex;
  final int selIndex;
  final IconData navIcon;
  final void Function() navFn;

  @override
  Widget build(BuildContext context) {
    Color onNavSelCol = Colors.white;
    Color onNavUnSelCol = Colors.grey;
    return AnimatedScale(
      duration: const Duration(seconds: 1),
      scale: navIndex == selIndex ? 1.15 : 1,
      curve: curves,
      child: IconButton(
        onPressed: navFn,
        icon: Icon(
          navIcon,
          color: navIndex == selIndex ? onNavSelCol : onNavUnSelCol,
          size: 35,
        ),
      ),
    );
  }
}
