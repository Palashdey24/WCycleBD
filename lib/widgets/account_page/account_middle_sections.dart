import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/model/account_option_model.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/card_with_outlined.dart';

final fontHelper = FontHelper();

final accountOption = [
  AccountOptionModel(
      optionLabel: "Wishlist",
      iconColors: Colors.indigoAccent,
      iconData: Icons.favorite_border_outlined),
  AccountOptionModel(
      optionLabel: "Notifications",
      iconColors: Colors.blueAccent,
      iconData: FontAwesomeIcons.noteSticky),
  AccountOptionModel(
      optionLabel: "Change Password",
      iconColors: Colors.grey,
      iconData: FontAwesomeIcons.lockOpen),
];

class AccountMiddleSections extends StatelessWidget {
  const AccountMiddleSections({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithOutlined(
      cardWidget: Column(
        children: [
          for (var accOptions in accountOption)
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: FaIcon(
                  accOptions.iconData,
                  color: accOptions.iconColors,
                ),
                title: Text(
                  accOptions.optionLabel,
                  style: fontHelper
                      .bodyMedium(context)
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
