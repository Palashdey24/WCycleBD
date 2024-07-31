import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';

final fontHelper = FontHelper();

class OrganizationDocs extends StatelessWidget {
  const OrganizationDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Upload Docs",
          style: fontHelper.bodyMedium(context).copyWith(color: Colors.green),
        ),
        const Gap(largeGap),
        ElevatedButton(
            onPressed: () {},
            child: const FaIcon(
              FontAwesomeIcons.solidEnvelopeOpen,
              color: Colors.orange,
            )),
      ],
    );
  }
}
