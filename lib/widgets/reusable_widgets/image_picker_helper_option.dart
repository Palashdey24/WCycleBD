import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';

final fontHelper = FontHelper();

class ImagePickerHelperOption extends StatelessWidget {
  const ImagePickerHelperOption(
      {super.key,
      required this.faIcons,
      required this.colos,
      required this.optiontxt});
  final IconData faIcons;
  final Color colos;
  final String optiontxt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          maxRadius: 30,
          child: FaIcon(
            faIcons,
            color: colos,
            size: 25,
            shadows: const [
              Shadow(color: Colors.cyan),
              Shadow(color: Colors.orange)
            ],
          ),
        ),
        const Gap(normalGap),
        Text(
          optiontxt,
          style: fontHelper.bodyLarge(context),
        ),
      ],
    );
  }
}
