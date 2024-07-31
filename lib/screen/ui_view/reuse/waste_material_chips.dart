import 'package:flutter/material.dart';
import 'package:wcycle_bd/helper/font_helper.dart';

final fontHelper = FontHelper();

class WasteMaterialChips extends StatelessWidget {
  const WasteMaterialChips({super.key, required this.ltWCat});

  final List<String> ltWCat;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 5,
      spacing: 5,
      children: [
        for (var wasteMat in ltWCat)
          Chip(
            backgroundColor: Colors.blueGrey,
            side: const BorderSide(color: Colors.green),
            label: Text(
              wasteMat.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 8),
            ),
          ),
      ],
    );
  }
}
