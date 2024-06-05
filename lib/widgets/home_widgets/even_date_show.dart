import 'package:flutter/material.dart';

class EvenDateShow extends StatelessWidget {
  const EvenDateShow({super.key, required this.dmyTxt});
  final String dmyTxt;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(3),
        height: 30,
        child: Text(
          dmyTxt,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
