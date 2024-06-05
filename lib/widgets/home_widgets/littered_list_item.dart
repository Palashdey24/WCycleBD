import 'package:flutter/material.dart';
import 'package:wcycle_bd/model/littered_list_model.dart';
import 'package:wcycle_bd/widgets/home_widgets/littered_list_item_info.dart';

class LitteredListItem extends StatelessWidget {
  const LitteredListItem({super.key, required this.ltListModel});

  final LitteredListModel ltListModel;

  @override
  Widget build(BuildContext context) {
    final imgSrc = ltListModel.ltSrc;

    final srcWidth = MediaQuery.sizeOf(context).width;
    return Stack(
      children: [
        SizedBox(
          width: srcWidth / 2,
          height: 140,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 8, top: 5),
                  clipBehavior: Clip.hardEdge,
                  width: srcWidth / 2.5,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.10),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: LitteredListItemInfo(ltList: ltListModel)),
              Positioned(
                top: 20,
                left: 5,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(5), right: Radius.circular(40)),
                  child: Image.asset(
                    fit: BoxFit.fill,
                    imgSrc,
                    height: 100,
                    width: srcWidth / 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
