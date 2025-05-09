import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wcycle_bd/data/model/remote/recycle_product_model.dart';
import 'package:wcycle_bd/provider/individual_store_provider.dart';
import 'package:wcycle_bd/provider/recycable_provider.dart';
import 'package:wcycle_bd/screen/ui_view/details/recycable_product_details.dart';
import 'package:wcycle_bd/widgets/home_pages/recyclable_list_item_info.dart';

class RecyclableListItem extends ConsumerWidget {
  const RecyclableListItem({
    super.key,
    this.rcListModel,
    this.isDtPage,
  });

  final RecycleProductModel? rcListModel;
  final bool? isDtPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rcProviderFn = ref.read(recycableProvider.notifier);
    final shopProviderfn = ref.read(individualStoreProvider.notifier);
    return Stack(
      children: [
        SizedBox(
          width: 120,
          height: 140,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GestureDetector(
                onTap: rcListModel != null
                    ? () {
                        rcProviderFn.onChange(rcListModel!);
                        shopProviderfn.shopData(context, rcListModel!.shopID);
                        if (!isDtPage!) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RecycleProductDetails(),
                              ));
                        }
                      }
                    : null,
                child: Container(
                  margin: const EdgeInsets.only(left: 10, top: 20),
                  width: 100,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.yellowAccent.withOpacity(0.4),
                      Colors.blueGrey,
                    ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: rcListModel != null
                      ? RecyclableListItemInfo(rcListModel: rcListModel!)
                      : null,
                ),
              ),
              Positioned(
                  top: 0,
                  left: 10,
                  child: Transform.rotate(
                    angle: 0.5,
                    child: CircleAvatar(
                      backgroundColor: rcListModel != null
                          ? Colors.transparent
                          : Colors.white,
                      radius: 29,
                      child: rcListModel != null
                          ? FadeInImage(
                              placeholder: MemoryImage(kTransparentImage),
                              image: NetworkImage(rcListModel!.productImage))
                          : null,
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
