import 'package:flutter/material.dart';

class NavIconItem extends StatelessWidget {
  const NavIconItem(
      {super.key,
      required this.isSelect,
      required this.curves,
      required this.navIcon,
      required this.navFn});

  final bool isSelect;
  final Curve curves;
  final IconData navIcon;
  final void Function() navFn;

  @override
  Widget build(BuildContext context) {
    Color onNavSelCol = Colors.white;
    Color onNavUnSelCol = Colors.grey;
    return AnimatedScale(
      duration: const Duration(seconds: 1),
      scale: isSelect ? 1.15 : 1,
      curve: curves,
      child: IconButton(
        onPressed: navFn,
        icon: Icon(
          navIcon,
          color: isSelect ? onNavSelCol : onNavUnSelCol,
          size: 35,
        ),
      ),
    );
  }
}
