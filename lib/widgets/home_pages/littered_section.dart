import 'package:flutter/material.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/model/littered_model.dart';
import 'package:wcycle_bd/screen/ui_view/littered_spot_list_ui.dart';
import 'package:wcycle_bd/screen/ui_view/shimmer/lt_shimmer.dart';
import 'package:wcycle_bd/widgets/home_pages/littered_list_item.dart';
import 'package:wcycle_bd/widgets/home_pages/section_top_bar.dart';

final apis = Apis();

class LitteredSpotSection extends StatelessWidget {
  const LitteredSpotSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<LitteredModel> ltModel = [];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionTopBar(
            stTxt: "Littered Spot",
            onMore: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LitteredSpotListUi(
                    ltModel: ltModel,
                  ),
                ))),
        SizedBox(
          height: 150,
          child: StreamBuilder(
              stream: apis.fireStore
                  .collection('litteredSpot')
                  .where("productOnline", isEqualTo: true)
                  .snapshots(),
              builder: (BuildContext context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const SizedBox(
                      height: 300,
                      child: LtShimmer(),
                    );

                  case ConnectionState.active:
                  case ConnectionState.done:
                    final datas = snapshot.data!.docs;

                    //Add data to model list one after one
                    ltModel = datas
                        .map(
                          (e) => LitteredModel.fromJson(e.data()),
                        )
                        .toList();

/*                    for (var inout in datas!) {
                      ltModel.add(LitteredModel.fromJson(inout.data()));
                    }*/
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ltModel.length,
                  itemBuilder: (context, index) {
                    return LitteredListItem(ltListModel: ltModel[index]);
                  },
                );
              }),
        ),
      ],
    );
  }
}
