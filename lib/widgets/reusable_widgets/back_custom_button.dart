import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BackCustomButton extends StatelessWidget {
  const BackCustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 15,
        child: IconButton(
            onPressed: () => Navigator.pop(context),
            alignment: Alignment.center,
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.blueGrey,
              size: 15,
            )),
      ),
    );
  }
}
