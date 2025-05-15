import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/device_size.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/back_custom_button.dart';

final apis = Apis();
final fontHelpers = FontHelper();

class DetailsFrameOne extends StatelessWidget {
  const DetailsFrameOne({
    super.key,
    required this.infoSections,
    this.bottomPosWidgets,
    required this.stackImage,
  });

  final Widget infoSections;
  final Widget? bottomPosWidgets;

  final String stackImage;

  @override
  Widget build(BuildContext context) {
    final imageHeight = apis.deviceHeight(context) * 0.30;
    return Stack(
      children: [
        Container(
          height: imageHeight,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Colors.green,
          ], begin: Alignment.topCenter, end: Alignment.bottomLeft)),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.white, Colors.white],
                    stops: [0.0, 0.35, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: SizedBox(
                  height: imageHeight,
                  width: double.infinity,
                  child: FadeInImage.memoryNetwork(
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                      image: stackImage),
                ),
              ),
            ],
          ),
        ),
        CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverGap(imageHeight - 50),
            SliverList(
                delegate: SliverChildListDelegate([
              Stack(
                clipBehavior: Clip.antiAlias,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: DeviceSize.getDeviceHeight(context) -
                              imageHeight +
                              50),
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
                  ),
                  Positioned(
                      bottom: 5,
                      child: SizedBox(
                          width: apis.deviceWidth(context),
                          child: bottomPosWidgets)),
                ],
              ),
            ])),
          ],
        ),
        const Positioned(top: 10, child: BackCustomButton())
      ],
    );
  }
}
