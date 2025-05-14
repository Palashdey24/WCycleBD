import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/users.dart';

class EventInterestUserUi extends StatelessWidget {
  const EventInterestUserUi({super.key, this.colors, required this.user});

  final Color? colors;
  final Users user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors,
      padding: const EdgeInsets.all(8),
      child: Flex(
        direction: Axis.horizontal,
        spacing: largeGap,
        children: [
          Expanded(
            flex: 20,
            child: CircleAvatar(
              radius: 20,
              backgroundImage: CachedNetworkImageProvider(user.imgUri),
            ),
          ),
          Expanded(
            flex: 80,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: csGap,
              children: [
                Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user.userName,
                        style: FontHelper()
                            .bodyMedium(context)
                            .copyWith(color: Colors.blueGrey),
                      ),
                      if (user.individual != true)
                        Text(
                          user.gender,
                          style: FontHelper()
                              .bodySmall(context)
                              .copyWith(color: Colors.orangeAccent),
                        )
                    ]),
                if (user.individual != true)
                  Text(user.phoneNumber,
                      style: FontHelper()
                          .bodyMedium(context)
                          .copyWith(color: Colors.blueGrey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
