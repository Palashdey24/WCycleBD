import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/model/store_model.dart';

class ShopListItemInfo extends StatelessWidget {
  const ShopListItemInfo({super.key, required this.shopModel});
  final StoreModel shopModel;
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
            flex: 1,
            child: ClipRRect(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: shopModel.logoUri,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )),
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  const Gap(2),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          shopModel.storeName,
                          style: FontHelper()
                              .bodySmall(context)
                              .copyWith(color: Colors.blue),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.solidStar,
                              size: 10,
                              color: Colors.redAccent,
                            ),
                            Text(
                              "${shopModel.rating}",
                              textAlign: TextAlign.center,
                              style: FontHelper().bodySmall(context).copyWith(
                                    color: Colors.redAccent,
                                  ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.locationPin,
                        size: 10,
                        color: Colors.green,
                      ),
                      const Gap(3),
                      Flexible(
                        child: Text(
                          shopModel.locations.address,
                          textAlign: TextAlign.left,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.lato(
                            fontSize: 8,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
