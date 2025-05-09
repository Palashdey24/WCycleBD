import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/model/account_option_model.dart';
import 'package:wcycle_bd/pages/wishlists_page.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/card_with_outlined.dart';

final fontHelper = FontHelper();

class AccountMiddleSections extends StatelessWidget {
  const AccountMiddleSections({super.key});

  @override
  Widget build(BuildContext context) {
    final accountOption = [
      AccountOptionModel(
        optionLabel: "Wishlist",
        iconColors: Colors.indigoAccent,
        iconData: Icons.favorite_border_outlined,
        btFn: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WishlistsPage(),
            )),
      ),
      AccountOptionModel(
          optionLabel: "Notifications",
          iconColors: Colors.blueAccent,
          iconData: FontAwesomeIcons.noteSticky),
      AccountOptionModel(
          optionLabel: "Change Password",
          iconColors: Colors.grey,
          iconData: FontAwesomeIcons.lockOpen),
    ];

    return CardWithOutlined(
      cardWidget: Column(
        children: [
          for (var accOptions in accountOption)
            InkWell(
              onTap: accOptions.btFn,
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
