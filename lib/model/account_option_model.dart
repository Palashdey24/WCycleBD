import 'package:flutter/material.dart';

class AccountOptionModel {
  AccountOptionModel({
    required this.optionLabel,
    required this.iconColors,
    required this.iconData,
  });
  final String optionLabel;
  final Color iconColors;
  final IconData iconData;
}
