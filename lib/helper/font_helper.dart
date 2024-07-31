import 'package:flutter/material.dart';

class FontHelper {
  TextStyle bodyLarge(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontSize: 20, fontWeight: FontWeight.bold);
  }

  TextStyle bodyMedium(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(fontSize: 15, fontWeight: FontWeight.bold);
  }

  TextStyle bodySmall(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodySmall!
        .copyWith(fontSize: 10, fontWeight: FontWeight.bold);
  }
}
