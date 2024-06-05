import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/data/littered_list_data.dart';
import 'package:wcycle_bd/data/recycable_price_data.dart';
import 'package:wcycle_bd/widgets/home_widgets/carousel_card.dart';
import 'package:wcycle_bd/widgets/home_widgets/event_section.dart';
import 'package:wcycle_bd/widgets/home_widgets/littered_list_item.dart';
import 'package:wcycle_bd/widgets/home_widgets/littered_section.dart';
import 'package:wcycle_bd/widgets/home_widgets/recyclable_list_item.dart';
import 'package:wcycle_bd/widgets/home_widgets/recyclable_price_section.dart';

import 'package:wcycle_bd/widgets/home_widgets/reuseable_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Swiper(
            loop: false,
            itemHeight: 200,
            itemWidth: 800,
            duration: 1200,
            layout: SwiperLayout.TINDER,
            scrollDirection: Axis.horizontal,
            itemCount: litteredListData.length,
            itemBuilder: (context, index) {
              return const ReuseableContainer(
                ctColor: Colors.orange,
                ctMargin: EdgeInsets.all(22),
                ctWidget: ReuseableContainer(
                  ctColor: Colors.blueGrey,
                  ctMargin: EdgeInsets.only(right: 10),
                  ctWidget: CarouselCard(),
                ),
              );
            },
          ),
          const Gap(10),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            child: const Column(
              children: [
                RecyclablePriceSection(),
                Gap(10),
                LitteredSpotSection(),
                Gap(10),
                EventSection(),
                Gap(10),
                LitteredSpotSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
