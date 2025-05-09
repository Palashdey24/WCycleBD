import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/littered_model.dart';
import 'package:wcycle_bd/pages/add/add_littered_spot_items.dart';
import 'package:wcycle_bd/provider/current_user_fs_provider.dart';
import 'package:wcycle_bd/widgets/home_pages/littered_list_item.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/search_box.dart';

class LitteredSpotListUi extends ConsumerWidget {
  const LitteredSpotListUi({super.key, required this.ltModel});

  final List<LitteredModel> ltModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(currentUserdataProvider);
    return Scaffold(
      floatingActionButton: user.individual == true
          ? FloatingActionButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddLitteredSpotItems(),
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
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: ltModel.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, bottom: 8),
                  child: LitteredListItem(
                    ltListModel: ltModel[index],
                    isVertical: true,
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
