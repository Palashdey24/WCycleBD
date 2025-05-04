import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/provider/user_fs_provider.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/card_with_outlined.dart';

class OrganizerCardWidget extends ConsumerWidget {
  const OrganizerCardWidget(
    this.organizerID, {
    super.key,
  });

  final String organizerID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //ref.watch(userFSProvider.notifier).intiValue(context, organizerID);
    final organizerProvider = ref.watch(userFSProvider);
    ImageProvider shopImage = const AssetImage("assets/PersonAvater.png");

    if (organizerProvider.imgUri != "N?A") {
      shopImage = NetworkImage(organizerProvider.imgUri);
    }
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: CardWithOutlined(
          horiMargin: 30,
          cardWidget: Flex(
            mainAxisAlignment: MainAxisAlignment.center,
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 30,
                child: CircleAvatar(
                  radius: 35,
                  foregroundImage: shopImage,
                ),
              ),
              Expanded(
                  flex: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(5),
                      Text(
                        organizerProvider.userName,
                        textAlign: TextAlign.left,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Gap(5),
                      Text(
                        "Organizer",
                        style: TextStyle(
                            fontSize: 12, color: Colors.yellow.shade100),
                      ),
                      const Gap(5),
                      Row(
                        children: [
                          Text(
                            "Email:${organizerProvider.email}",
                            style: FontHelper()
                                .bodySmall(context)
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
}
