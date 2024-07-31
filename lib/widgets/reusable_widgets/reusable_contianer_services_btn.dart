import 'package:flutter/material.dart';
import 'package:wcycle_bd/helper/font_helper.dart';

final fontHelper = FontHelper();

class ReusableContianerServicesBtn extends StatelessWidget {
  const ReusableContianerServicesBtn(
      {super.key, required this.btntext, this.onBtnTap, this.colors});

  final String btntext;
  final void Function()? onBtnTap;
  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onBtnTap,
        child: Container(
          alignment: Alignment.center,
          height: 48,
          decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: colors ??
                    [
                      Colors.blue,
                      Colors.white,
                    ],
                radius: 7),
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          child: Text(
            btntext,
            style: fontHelper.bodyMedium(context),
          ),
        ),
      ),
    );
  }
}
