import 'package:flutter/material.dart';

class CardTextFields extends StatelessWidget {
  const CardTextFields({super.key, required this.cardWidegts});

  final Widget cardWidegts;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: cardWidegts,
      ),
    );
  }
}
