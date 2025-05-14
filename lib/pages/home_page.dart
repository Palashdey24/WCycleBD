import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/provider/current_user_fs_provider.dart';
import 'package:wcycle_bd/provider/news_data.dart';
import 'package:wcycle_bd/provider/users_fs_provider.dart';
import 'package:wcycle_bd/widgets/home_pages/event_section.dart';
import 'package:wcycle_bd/widgets/home_pages/littered_section.dart';
import 'package:wcycle_bd/widgets/home_pages/recyclable_price_section.dart';
import 'package:wcycle_bd/widgets/home_pages/recycle_shop_section.dart';
import 'package:wcycle_bd/widgets/home_pages/service_section.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/carousel_card.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/reuseable_container.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(currentUserdataProvider.notifier)
        .intiValue(context, FirebaseAuth.instance.currentUser!.uid.toString());
    ref.read(usersFsProviders.notifier).loadUsersAllData();
    final user = ref.watch(currentUserdataProvider);
    final newsData = ref.watch(newsFSProvider);

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Swiper(
          loop: false,
          itemHeight: 200,
          itemWidth: 800,
          duration: 1200,
          layout: SwiperLayout.TINDER,
          scrollDirection: Axis.horizontal,
          itemCount: newsData.length,
          itemBuilder: (context, index) {
            return ReuseableContainer(
              ctColor: Colors.orange,
              ctMargin: const EdgeInsets.all(22),
              ctWidget: ReuseableContainer(
                ctColor: Colors.blueGrey,
                ctMargin: const EdgeInsets.only(right: 10),
                ctWidget: CarouselCard(
                  newsModel: newsData[index],
                ),
              ),
            );
          },
        ),
        const Gap(10),
        SizedBox(
          width: double.infinity,
          child: Column(
            spacing: normalGap,
            children: [
              if (user.individual == true) const RecyclablePriceSection(),
              const LitteredSpotSection(),
              const ServiceSection(),
              const EventSection(),
              if (user.individual == true) const RecycleShopSection(),
              const Gap(40),
            ],
          ),
        ),
      ],
    );
  }
}
