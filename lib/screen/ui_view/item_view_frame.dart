import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/search_box.dart';

class ItemViewFrame extends StatelessWidget {
  const ItemViewFrame({super.key, this.detailsWidget, required this.viewType});

  final Widget? detailsWidget;
  final Widget viewType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: detailsWidget != null
          ? FloatingActionButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => detailsWidget!,
                  )),
              child: const Icon(Icons.add_circle),
            )
          : null,
      body: SafeArea(
          child: Column(
        children: [
          const SearchBox(),
          const Gap(normalGap),
          Expanded(
            child: viewType,
          ),
        ],
      )),
    );
  }
}
