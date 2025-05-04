import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd/helper/font_helper.dart';

class CustomPlusMinusItemCore extends StatelessWidget {
  const CustomPlusMinusItemCore(
      {super.key,
      required this.onPlusFn,
      required this.onMinusFn,
      required this.quantity});

  final void Function() onPlusFn;
  final void Function() onMinusFn;

  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: onPlusFn,
            icon: const CircleAvatar(
              radius: 10,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.add,
                size: 15,
                color: Colors.teal,
              ),
            )),
        Text(
          "$quantity",
          softWrap: true,
          style: FontHelper().bodyMedium(context).copyWith(color: Colors.black),
        ),
        IconButton(
            onPressed: onMinusFn,
            icon: const CircleAvatar(
              radius: 10,
              backgroundColor: Colors.yellowAccent,
              child: FaIcon(
                FontAwesomeIcons.minus,
                size: 15,
                color: Colors.red,
              ),
            )),
      ],
    );
  }
}
