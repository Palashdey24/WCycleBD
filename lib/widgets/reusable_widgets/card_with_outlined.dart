import 'package:flutter/material.dart';

class CardWithOutlined extends StatelessWidget {
  const CardWithOutlined({super.key, required this.cardWidget});

  final Widget cardWidget;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      color: const Color.fromARGB(226, 26, 52, 50),
      child: Card(
        margin: const EdgeInsets.only(left: 6),
        color: Colors.white24,
        elevation: 10,
        child: cardWidget,
      ),
    );
  }
}
