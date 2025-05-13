import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/news_model.dart';
import 'package:wcycle_bd/screen/ui_view/shimmer/lt_shimmer.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/carousel_card.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<NewsModel>? newsDataList = [];

    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("News").get(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const SizedBox(
                height: 150,
                child: LtShimmer(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              final newsData = snapshot.data!.docs;
              //Add data to model list one after one
/*                        litteredDataList = litteredData.map((e) {
                          return LitteredModel.fromJson(e.data());
                        }).toList();*/
              newsDataList = newsData.map(
                (e) {
                  return NewsModel.fromJson(e.data());
                },
              ).toList();
          }
          return GridView.builder(
            itemCount: newsDataList!.length,
            itemBuilder: (context, index) {
              return CarouselCard(
                newsModel: newsDataList![index],
              );
            },
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 1,
                mainAxisSpacing: largeGap,
                crossAxisSpacing: largeGap),
          );
        });
  }
}
