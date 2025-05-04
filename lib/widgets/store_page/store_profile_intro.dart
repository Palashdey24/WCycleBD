import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/store_model.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/back_custom_button.dart';

class StoreProfileIntro extends StatelessWidget {
  const StoreProfileIntro({super.key, required this.storeModel});
  final StoreModel storeModel;

  @override
  Widget build(BuildContext context) {
    final StoreModel(
      :storeName,
      :storeAddress,
      :logoUri,
    ) = storeModel;
    return Container(
      padding: const EdgeInsets.all(largeGap),
      height: 220,
      child: Stack(
        children: [
          Flex(
            direction: Axis.horizontal,
            spacing: largeGap,
            children: [
              Container(
                width: 100,
                height: 100,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey),
                child: CachedNetworkImage(
                  imageUrl: logoUri,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Image.memory(kTransparentImage),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Flex(
                direction: Axis.vertical,
                spacing: csGap,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(storeName, style: FontHelper().bodyLarge(context)),
                  Flex(
                    direction: Axis.horizontal,
                    spacing: 5,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.locationDot,
                        size: 20,
                        color: Colors.black12,
                      ),
                      Text(
                        storeAddress,
                        style: FontHelper()
                            .bodySmall(context)
                            .copyWith(color: Colors.black87),
                      ),
                    ],
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    spacing: 5,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.solidSun,
                        size: 20,
                        color: Colors.blueGrey,
                      ),
                      Text(
                        "4.5",
                        style: FontHelper()
                            .bodySmall(context)
                            .copyWith(color: Colors.blueGrey),
                      ),
                      const Gap(largeGap),
                      const FaIcon(
                        FontAwesomeIcons.certificate,
                        size: 20,
                        color: Colors.blueGrey,
                      ),
                      Text(
                        "Beginner",
                        style: FontHelper()
                            .bodySmall(context)
                            .copyWith(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          const Positioned(top: csGap, child: BackCustomButton())
        ],
      ),
    );
  }
}
