import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/provider/current_user_fs_provider.dart';
import 'package:wcycle_bd/provider/news_data.dart';
import 'package:wcycle_bd/provider/recycable_fs_data.dart';
import 'package:wcycle_bd/provider/store_fs_data.dart';
import 'package:wcycle_bd/provider/user_address_provider.dart';
import 'package:wcycle_bd/screen/home_screen.dart';

import '../provider/local_cart_provider.dart' show localCartIntiProvider;

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(userAddressDataProvider.notifier).fetchData();
    ref
        .read(currentUserdataProvider.notifier)
        .intiValue(context, FirebaseAuth.instance.currentUser!.uid.toString());
    ref.read(newsFSProvider.notifier).newsData();
    ref.read(storeFsDataProvider.notifier).loadStoreAllData();
    ref.read(recycleFsDataProvider.notifier).fetchData().whenComplete(
      () {
        ref
            .read(localCartIntiProvider.notifier)
            .loadIntiCartData()
            .whenComplete(
          () {
            if (!context.mounted) return;
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        );
      },
    );

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
