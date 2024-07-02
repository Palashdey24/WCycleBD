import 'dart:async';
import 'dart:core';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wcycle_bd/pages/account_page.dart';
import 'package:wcycle_bd/pages/home_page.dart';
import 'package:wcycle_bd/pages/news_page.dart';
import 'package:wcycle_bd/pages/order_page.dart';
import 'package:wcycle_bd/screen/credentials_screen.dart';
import 'package:wcycle_bd/utilts/global_value.dart';
import 'package:wcycle_bd/api/apis.dart';
import 'package:wcycle_bd/widgets/nav_icon_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool onNavHm = true;
  bool onNavOd = false;
  bool onNavNs = false;
  bool onNavAcc = false;

  int currentIndex = 0;

  final pages = [
    const HomePage(),
    const OrderPage(),
    const NewsPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultColor,
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
        title: Text(
          appName,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
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
            NavIconItem(
              isSelect: onNavHm,
              curves: Curves.easeInSine,
              navIcon: Icons.home,
              navFn: () {
                setState(() {
                  onNavHm = true;
                  onNavAcc = false;
                  onNavOd = false;
                  onNavNs = false;
                  currentIndex = 0;
                });
              },
            ),
            NavIconItem(
              isSelect: onNavOd,
              curves: Curves.bounceOut,
              navIcon: Icons.add_shopping_cart,
              navFn: () {
                setState(() {
                  onNavHm = false;
                  onNavAcc = false;
                  onNavOd = true;
                  onNavNs = false;
                  currentIndex = 1;
                });
              },
            ),
            NavIconItem(
              isSelect: onNavNs,
              curves: Curves.bounceIn,
              navIcon: Icons.newspaper_rounded,
              navFn: () {
                setState(() {
                  onNavHm = false;
                  onNavAcc = false;
                  onNavOd = false;
                  onNavNs = true;
                  currentIndex = 2;
                });
              },
            ),
            NavIconItem(
              isSelect: onNavAcc,
              curves: Curves.easeInCubic,
              navIcon: Icons.person_2_rounded,
              navFn: () async {
                await Apis().firebaseAuth.signOut();
                await GoogleSignIn().signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CredentialScreen(),
                    ));
                setState(() {
                  onNavHm = false;
                  onNavAcc = true;
                  onNavOd = false;
                  onNavNs = false;
                  currentIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
      body: pages[currentIndex],
    );
  }
}
