import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/model/littered_model.dart';
import 'package:wcycle_bd/screen/ui_view/details/littered_spot_details.dart';
import 'package:wcycle_bd/widgets/home_pages/littered_list_item_info.dart';

final apis = Apis();

class LitteredListItem extends StatelessWidget {
  const LitteredListItem(
      {super.key, required this.ltListModel, this.isVertical});

  final LitteredModel ltListModel;
  final bool? isVertical;

  @override
  Widget build(BuildContext context) {
    final imgSrc = ltListModel.ltSrc;
    return Stack(
      children: [
        InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LitteredSpotDetails(
                  ltData: ltListModel,
                ),
              )),
          child: SizedBox(
            width: isVertical != null
                ? (apis.deviceWidth(context) / 1)
                : (apis.deviceWidth(context) / 2),
            height: 140,
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 8, top: 5),
                    clipBehavior: Clip.hardEdge,
                    width: isVertical != null
                        ? (apis.deviceWidth(context) / 1.10)
                        : apis.deviceWidth(context) / 2.5,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.10),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: LitteredListItemInfo(
                      ltList: ltListModel,
                      isVertical: isVertical,
                    )),
                Positioned(
                  top: 20,
                  left: 5,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(5), right: Radius.circular(40)),
                    child: FadeInImage.memoryNetwork(
                      fit: BoxFit.fill,
                      placeholder: kTransparentImage,
                      image: imgSrc,
                      height: 100,
                      width: apis.deviceWidth(context) / 5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
