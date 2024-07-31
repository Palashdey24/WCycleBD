import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/model/recyclable_list_model.dart';
import 'package:wcycle_bd/provider/recycable_provider.dart';
import 'package:wcycle_bd/screen/ui_view/details/recycable_product_details.dart';
import 'package:wcycle_bd/utilts/string.dart';
import 'package:wcycle_bd/widgets/home_pages/recyclable_list_item_info.dart';

class RecyclableListItem extends ConsumerWidget {
  const RecyclableListItem({
    super.key,
    required this.rcListModel,
    required this.isDtPage,
  });

  final RecyclableListModel rcListModel;
  final bool isDtPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rcProviderFn = ref.read(recycableProvider.notifier);
    return Stack(
      children: [
        SizedBox(
          width: 120,
          height: 140,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              InkWell(
                onTap: () {
                  rcProviderFn.onChange(rcListModel);
                  if (!isDtPage) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecycableProductDetails(),
                        ));
                  }
                },
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
                  child: RecyclableListItemInfo(rcListModel: rcListModel),
                ),
              ),
              Positioned(
                  top: 0,
                  left: 10,
                  child: Transform.rotate(
                    angle: 0.5,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 29,
                      child: FadeInImage(
                          placeholder: const AssetImage(appLogo),
                          image: AssetImage("assets/${rcListModel.imgRsc}")),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
