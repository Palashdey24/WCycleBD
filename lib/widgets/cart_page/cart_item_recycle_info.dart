import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd/helper/pre_style.dart';

class CartItemRecycleInfo extends StatefulWidget {
  const CartItemRecycleInfo({super.key});

  @override
  State<CartItemRecycleInfo> createState() => _CartItemRecycleInfoState();
}

class _CartItemRecycleInfoState extends State<CartItemRecycleInfo> {
  bool selectCart = false;
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Radio(
          value: selectCart,
          groupValue: selectCart,
          onChanged: (value) {
            setState(() {
              selectCart = value!;
              log(value.toString());
            });
          },
        ),
        Expanded(
            flex: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(normalGap),
              child: Image.asset(
                "assets/metal-field.jpg",
              ),
            )),
        const Expanded(
          flex: 50,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Wrap(
              direction: Axis.vertical,
              spacing: 5,
              children: [
                Text(
                  "Plastic",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "\$ 17x5",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  "\$95",
                  style: TextStyle(color: Colors.orange),
                ),
              ],
            ),
          ),
        ),
        const Expanded(
            flex: 20,
            child: Wrap(
              spacing: 5,
              children: [
                CircleAvatar(
                  radius: normalGap,
                  child: FaIcon(
                    FontAwesomeIcons.minus,
                    size: normalGap,
                  ),
                ),
                Text(
                  "1",
                  style: TextStyle(color: Colors.lime),
                ),
                CircleAvatar(
                  radius: normalGap,
                  child: FaIcon(
                    FontAwesomeIcons.plus,
                    size: normalGap,
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
