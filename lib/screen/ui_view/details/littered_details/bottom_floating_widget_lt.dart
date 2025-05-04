import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/firebase_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/provider/user_fs_provider.dart';

class BottomFloatingWidgetLt extends ConsumerWidget {
  const BottomFloatingWidgetLt({super.key, this.onCreateEvent});

  final void Function()? onCreateEvent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(userFSProvider.notifier)
        .intiValue(context, FirebaseHelper.firebaseAuth.currentUser!.uid);
    final user = ref.watch(userFSProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
                onPressed: onCreateEvent, child: const Text("Create Event")),
          ),
          const Gap(normalGap),
          Expanded(
            child: ElevatedButton(
                onPressed: () {}, child: const Text("Direct Initiative")),
          ),
        ],
      ),
    );
  }
}
