import 'package:flutter/material.dart';

class AccountOptionModel {
  AccountOptionModel({
    required this.optionLabel,
    required this.iconColors,
    required this.iconData,
    this.btFn,
    this.btWidgets,
  });
  final String optionLabel;
  final Color iconColors;
  final IconData iconData;
  final void Function()? btFn;
  final Widget? btWidgets;
}
