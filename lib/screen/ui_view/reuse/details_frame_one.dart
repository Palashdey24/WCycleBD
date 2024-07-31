import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/back_custom_button.dart';

final apis = Apis();
final fontHelpers = FontHelper();

class DetailsFrameOne extends StatelessWidget {
  const DetailsFrameOne(
      {super.key,
      required this.infoSections,
      required this.bottomPosWidgets,
      required this.stackImage});

  final Widget infoSections;
  final Widget bottomPosWidgets;
  final String stackImage;

  @override
  Widget build(BuildContext context) {
    final imageHeight = apis.deviceHeight(context) * 0.30;
    return SafeArea(
      child: SizedBox(
        width: apis.deviceWidth(context),
        height: apis.deviceHeight(context),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            FadeInImage.memoryNetwork(
              fit: BoxFit.fill,
              placeholder: kTransparentImage,
              image: stackImage,
              height: imageHeight,
              width: double.infinity,
            ),
            Column(
              children: [
                Gap(imageHeight - 50),
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.antiAlias,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          color: Colors.white,
                          elevation: 10,
                          margin: const EdgeInsets.only(top: 17),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(30)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: infoSections,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 5,
                          child: SizedBox(
                              width: apis.deviceWidth(context),
                              child: bottomPosWidgets)),
                    ],
                  ),
                )
              ],
            ),
            const BackCustomButton(),
          ],
        ),
      ),
    );
  }
}
