import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/provider/local_cart_provider.dart';
import 'package:wcycle_bd/provider/news_data.dart';
import 'package:wcycle_bd/provider/recycable_fs_data.dart';
import 'package:wcycle_bd/provider/store_fs_data.dart';
import 'package:wcycle_bd/screen/auth_check_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
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
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const AuthCheckScreen()));
          },
        );
      },
    );

    ref.read(localCartProvider);

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
