import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/model/account_option_model.dart';
import 'package:wcycle_bd/screen/credentials_screen.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/card_with_outlined.dart';

final fontHelper = FontHelper();
final api = Apis();

final accountOption = [
  AccountOptionModel(
      optionLabel: "Terms and Conditions",
      iconColors: Colors.green,
      iconData: FontAwesomeIcons.terminal),
  AccountOptionModel(
      optionLabel: "Sign Out",
      iconColors: Colors.red,
      iconData: FontAwesomeIcons.arrowRightFromBracket),
];

class AccountBottomSections extends StatelessWidget {
  const AccountBottomSections({super.key});

  void onOptionTap(int index, BuildContext context) async {
    if (index == 1) {
      await api.firebaseAuth.signOut();
      await GoogleSignIn().signOut();
      if (!context.mounted) return;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CredentialScreen(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CardWithOutlined(
      cardWidget: Column(
        children: [
          for (var accOptions in accountOption)
            InkWell(
              onTap: () =>
                  onOptionTap(accountOption.indexOf(accOptions), context),
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
