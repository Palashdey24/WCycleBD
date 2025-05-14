import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';

class EventInterestUserUi extends StatelessWidget {
  const EventInterestUserUi(
      {super.key, required this.imageUrl, required this.userName});

  final String imageUrl;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange.withValues(alpha: 0.5),
      padding: const EdgeInsets.all(8),
      child: Flex(
        direction: Axis.horizontal,
        spacing: normalGap,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: CachedNetworkImageProvider(imageUrl),
          ),
          Text(
            userName,
            style: FontHelper().bodyMedium(context),
          )
        ],
      ),
    );
  }
}
