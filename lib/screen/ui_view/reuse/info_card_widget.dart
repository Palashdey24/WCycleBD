import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/model/store_model.dart';
import 'package:wcycle_bd/model/users.dart';
import 'package:wcycle_bd/provider/individual_store_provider.dart';
import 'package:wcycle_bd/provider/indiviual_user_fs_provider.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/card_with_outlined.dart';

class InfoCardWidget extends ConsumerWidget {
  const InfoCardWidget({
    super.key,
    required this.dataId,
    this.isEvent,
  });

  final String dataId;
  final bool? isEvent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    StoreModel? storeData;
    Users? userdata;
    String? name;
    String? image;
    String? metaData;
    if (isEvent == true) {
      ref.read(individualUserdataProvider.notifier).intiValue(dataId);
      userdata = ref.watch(individualUserdataProvider);
      name = userdata?.userName;
      image = userdata?.imgUri;
      metaData = "Organizer";
    } else {
      ref.read(individualStoreProvider.notifier).shopData(context, dataId);
      storeData = ref.watch(individualStoreProvider);
      name = storeData?.storeName;
      image = storeData?.logoUri;
      metaData = "Address: ${storeData?.locations.address}";
    }

    ImageProvider providerImage = const AssetImage("assets/PersonAvater.png");

    if (storeData != null || userdata != null) {
      providerImage = NetworkImage(image ??
          "https://firebasestorage.googleapis.com/v0/b/wcyclebd.appspot.com/o/black-orange-red-3d-abstract-wallpaper-ai-generative-free-photo.jpg?alt=media&token=bbed1f86-0cbc-497f-a795-78202e0960ab");
    }
    return GestureDetector(
      onTap:
          () {} /*=> Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StorePage(shopModel: dataProvider),
          ))*/
      ,
      child: SizedBox(
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
                    foregroundImage: providerImage,
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
                          name ?? "N/A",
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Gap(5),
                        Text(
                          metaData,
                          style: TextStyle(
                              fontSize: 12, color: Colors.yellow.shade100),
                        ),
                        const Gap(5),
                        if (isEvent == true)
                          Text(
                            "Email: ${userdata?.email}",
                            style: FontHelper()
                                .bodySmall(context)
                                .copyWith(color: Colors.white),
                          ),
                        if (isEvent != true)
                          Row(
                            children: [
                              const FaIcon(
                                  size: 15,
                                  color: Colors.red,
                                  FontAwesomeIcons.solidStar),
                              const Gap(5),
                              Text(
                                "${storeData?.rating}/${storeData!.totalRated}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
