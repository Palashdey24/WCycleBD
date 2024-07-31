import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/widgets/account_page/account_bottom_sections.dart';
import 'package:wcycle_bd/widgets/account_page/account_middle_sections.dart';
import 'package:wcycle_bd/widgets/account_page/account_top_scetions.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Gap(csGap),
          AccountTopScetions(),
          Gap(csGap),
          Divider(
            thickness: 2,
          ),
          AccountMiddleSections(),
          Gap(csGap),
          Divider(
            thickness: 2,
          ),
          AccountBottomSections()
        ],
      ),
    );
  }
}
