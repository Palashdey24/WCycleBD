import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/data/littered_list_data.dart';
import 'package:wcycle_bd/widgets/home_pages/carousel_card.dart';
import 'package:wcycle_bd/widgets/home_pages/event_section.dart';
import 'package:wcycle_bd/widgets/home_pages/littered_section.dart';
import 'package:wcycle_bd/widgets/home_pages/recyclable_price_section.dart';

import 'package:wcycle_bd/widgets/reusable_widgets/reuseable_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
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
            child: Column(
              children: [
                const RecyclablePriceSection(),
                const Gap(10),
                Animate(
                    effects: const [MoveEffect()],
                    child: const LitteredSpotSection()),
                const Gap(10),
                const EventSection(),
                const Gap(10),
                const LitteredSpotSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
