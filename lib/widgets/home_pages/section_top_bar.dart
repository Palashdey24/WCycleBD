import 'package:flutter/material.dart';

class SectionTopBar extends StatelessWidget {
  const SectionTopBar({super.key, required this.stTxt, required this.onMore});

  final String stTxt;
  final void Function() onMore;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, bottom: 0),
          child: Text(
            stTxt,
            style: theme.titleSmall!.copyWith(color: Colors.white),
          ),
        ),
        const Spacer(),
        TextButton.icon(
          onPressed: onMore,
          label: const Text("More"),
          icon: const Icon(Icons.forward),
          iconAlignment: IconAlignment.end,
        )
      ],
    );
  }
}
