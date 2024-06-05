import 'package:flutter/material.dart';
import 'package:wcycle_bd/model/recyclable_list_model.dart';
import 'package:wcycle_bd/widgets/home_widgets/recyclable_list_item_info.dart';

class RecyclableListItem extends StatelessWidget {
  const RecyclableListItem({super.key, required this.rcListModel});

  final RecyclableListModel rcListModel;

  @override
  Widget build(BuildContext context) {
    final imgSrc = rcListModel.imgRsc;

    return Stack(
      children: [
        SizedBox(
          width: 120,
          height: 140,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
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
              Positioned(
                  top: 0,
                  left: 20,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(imgSrc),
                    radius: 30,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
