import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/model/users.dart';
import 'package:wcycle_bd/provider/current_user_fs_provider.dart';

class EventInterestUserUi extends ConsumerWidget {
  const EventInterestUserUi({super.key, this.colors, required this.user});

  final Color? colors;
  final Users user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserdataProvider);
    return Container(
      color: colors ?? Colors.white,
      width: 150,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: CachedNetworkImageProvider(user.imgUri),
          ),
          Text(
            user.userName,
            style: FontHelper()
                .bodySmall(context)
                .copyWith(color: Colors.blueGrey),
          ),
          Text(
            user.gender,
            style: FontHelper()
                .bodySmall(context)
                .copyWith(color: Colors.orangeAccent),
          ),
          if (currentUser.individual == false || currentUser.individual == null)
            Text(user.phoneNumber,
                style: FontHelper()
                    .bodySmall(context)
                    .copyWith(color: Colors.blueGrey)),
        ],
      ),
    );
  }
}
