import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/account_option_model.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/upload_image.dart';

final fontHelper = FontHelper();

final accountOption = [
  AccountOptionModel(
      optionLabel: "Order",
      iconColors: Colors.amberAccent,
      iconData: Icons.inventory_rounded),
  AccountOptionModel(
      optionLabel: "Profile",
      iconColors: Colors.amberAccent,
      iconData: FontAwesomeIcons.usersRectangle),
  AccountOptionModel(
      optionLabel: "Address",
      iconColors: Colors.blueAccent,
      iconData: FontAwesomeIcons.addressBook),
  AccountOptionModel(
      optionLabel: "Setting",
      iconColors: Colors.grey,
      iconData: FontAwesomeIcons.seedling),
  AccountOptionModel(
      optionLabel: "Payment",
      iconColors: Colors.indigo,
      iconData: FontAwesomeIcons.paypal),
];

class AccountTopScetions extends StatelessWidget {
  const AccountTopScetions({super.key});

  @override
  Widget build(BuildContext context) {
    late String downloadUri;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: normalGap,
          children: [
            Stack(
              children: [
                UploadImage(
                  downloadUriFn: (uri) => downloadUri = uri,
                  storageRef: "users",
                  preImage: "assets/plastic_bottle.png",
                  radius: 50,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.penNib,
                        color: Colors.orange,
                        size: 20,
                      )),
                ),
              ],
            ),
            Text(
              "Name",
              style:
                  fontHelper.bodyMedium(context).copyWith(color: Colors.white),
            ),
            Text(
              "email@wbd.com",
              style: fontHelper.bodySmall(context).copyWith(color: Colors.grey),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Text(
                "Earned: 500",
                style: fontHelper.bodySmall(context).copyWith(
                      color: Colors.indigoAccent,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: csGap,
                children: [
                  for (var accOptions in accountOption)
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: FaIcon(
                            accOptions.iconData,
                            color: accOptions.iconColors,
                            size: 20,
                          ),
                        ),
                        const Gap(normalGap),
                        Text(
                          accOptions.optionLabel,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
