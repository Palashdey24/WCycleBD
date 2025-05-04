import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/account_option_model.dart';
import 'package:wcycle_bd/pages/home_page.dart';
import 'package:wcycle_bd/pages/profile_page.dart';
import 'package:wcycle_bd/provider/user_fs_provider.dart';

final fontHelper = FontHelper();

final accountOption = [
  AccountOptionModel(
      optionLabel: "Order",
      iconColors: Colors.amberAccent,
      iconData: Icons.inventory_rounded,
      btWidgets: const HomePage()),
  AccountOptionModel(
      optionLabel: "Profile",
      iconColors: Colors.amberAccent,
      iconData: FontAwesomeIcons.usersRectangle,
      btWidgets: const ProfilePage()),
  AccountOptionModel(
      optionLabel: "Address",
      iconColors: Colors.blueAccent,
      iconData: FontAwesomeIcons.addressBook,
      btWidgets: const HomePage()),
  AccountOptionModel(
      optionLabel: "Setting",
      iconColors: Colors.grey,
      iconData: FontAwesomeIcons.seedling,
      btWidgets: const HomePage()),
  AccountOptionModel(
      optionLabel: "Payment",
      iconColors: Colors.indigo,
      iconData: FontAwesomeIcons.paypal,
      btWidgets: const HomePage()),
];

class AccountTopScetions extends ConsumerWidget {
  const AccountTopScetions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userFSProvider);

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
                ClipOval(
                    child: users.imgUri.isEmpty
                        ? const CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                          )
                        : FadeInImage(
                            placeholder: MemoryImage(kTransparentImage),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              users.imgUri,
                            ),
                          )),
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
              users.userName,
              style:
                  fontHelper.bodyMedium(context).copyWith(color: Colors.white),
            ),
            Text(
              users.email,
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
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.blueGrey,
                          builder: (context) {
                            return Center(child: accOptions.btWidgets);
                          },
                        );
                      },
                      child: Column(
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
                      ),
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
