import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/recyclable_list_model.dart';
import 'package:wcycle_bd/provider/recycable_provider.dart';
import 'package:wcycle_bd/screen/ui_view/details/recycable_product_details.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/custome_gridview.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/search_box.dart';

final api = Apis();

class RecycableProductListUi extends ConsumerWidget {
  const RecycableProductListUi({super.key, required this.recycableList});

  final List<RecyclableListModel> recycableList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rcLMFn = ref.read(recycableProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SearchBox(),
            Expanded(
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(largeGap))),
                child: CustomeGridview(
                  rcList: recycableList,
                  isDtpage: false,
                  onTap: (index) {
                    rcLMFn.onChange(recycableList[index]);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecycableProductDetails(),
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
