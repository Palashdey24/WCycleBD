import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/model/nav_item_model.dart';
import 'package:wcycle_bd/pages/account_page.dart';
import 'package:wcycle_bd/pages/cart_page.dart';
import 'package:wcycle_bd/pages/home_page.dart';
import 'package:wcycle_bd/pages/news_page.dart';
import 'package:wcycle_bd/provider/user_fs_provider.dart';
import 'package:wcycle_bd/utilts/colors.dart';
import 'package:wcycle_bd/utilts/string.dart';
import 'package:wcycle_bd/widgets/nav_icon_item.dart';

final apis = Apis();
String userId = apis.currentUser.uid;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentIndex = 0;
  final uId = FirebaseAuth.instance.currentUser!.uid;
  late User user;

  @override
  void initState() {
    super.initState();
    ref.read(userFSProvider.notifier).intiValue(context, uId);
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userFSProvider);

    final pages = [
      const HomePage(),
      if (userInfo.individual == null || userInfo.individual != false)
        const Center(),
      const NewsPage(),
      const AccountPage(),
    ];

    final navItemList = [
      NavItemModel(curves: Curves.easeInSine, iconDatas: Icons.home),
      if (userInfo.individual == null || userInfo.individual != false)
        NavItemModel(
            curves: Curves.bounceOut, iconDatas: Icons.add_shopping_cart),
      NavItemModel(curves: Curves.bounceIn, iconDatas: Icons.newspaper_rounded),
      NavItemModel(
          curves: Curves.easeInCubic, iconDatas: Icons.person_2_rounded),
    ];

    return Scaffold(
      backgroundColor: kDefaultColor,
      extendBody: true,
      appBar: AppBar(
        shadowColor: Colors.blueGrey.shade600,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30))),
        elevation: 0,
        backgroundColor: kDefaultColor.withOpacity(0.1),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const CircleAvatar(
              backgroundImage: AssetImage("assets/PersonAvater.png"),
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notification_add_rounded,
                color: Colors.blueGrey,
              ))
        ],
        title: const Text(
          appName,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: Card(
        margin: const EdgeInsets.all(0),
        elevation: 0,
        color: Theme.of(context).colorScheme.secondary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (var navItems in navItemList)
              NavIconItem(
                  curves: navItems.curves,
                  navIcon: navItems.iconDatas,
                  navFn: () {
                    if (navItems.iconDatas == Icons.add_shopping_cart &&
                        userInfo.individual != false) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartPage(),
                          ));
                      return;
                    } else {
                      setState(() {
                        currentIndex = navItemList.indexOf(navItems);
                      });
                    }
                  },
                  navIndex: navItemList.indexOf(navItems),
                  selIndex: currentIndex)
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: IndexedStack(
              index: currentIndex,
              children: pages,
            )),
      ),
    );
  }
}
