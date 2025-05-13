import 'package:flutter/material.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/model/littered_model.dart';
import 'package:wcycle_bd/screen/ui_view/shimmer/lt_shimmer.dart';
import 'package:wcycle_bd/widgets/home_pages/section_top_bar.dart';

final apis = Apis();

class ServiceSection extends StatelessWidget {
  const ServiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<LitteredModel> ltModel = [];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionTopBar(
          stTxt: "Service",
          onMore: () => DialogsHelper.showMessage(context, "Work Progress"),
        ),
        SizedBox(
          height: 150,
          child: FutureBuilder(
              future: apis.fireStore.collection('litteredSpot').get(),
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

                return const Center(
                  child: Text(
                    "Will be Updated Soon",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
