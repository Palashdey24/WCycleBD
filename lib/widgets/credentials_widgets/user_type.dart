import 'package:flutter/material.dart';
import 'package:wcycle_bd/helper/font_helper.dart';

final fontHelper = FontHelper();

class UserType extends StatelessWidget {
  const UserType(
      {super.key, required this.userText, required this.animatedColors});
  final String userText;
  final Color animatedColors;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: animatedColors,
      margin: const EdgeInsets.only(left: 10),
      duration: const Duration(milliseconds: 1500),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          userText,
          textAlign: TextAlign.center,
          style: fontHelper.bodyMedium(context),
        ),
      ),
    );
  }
}
