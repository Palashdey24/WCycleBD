import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/provider/local_cart_provider.dart';
import 'package:wcycle_bd/provider/news_data.dart';
import 'package:wcycle_bd/provider/store_fs_data.dart';
import 'package:wcycle_bd/screen/auth_check_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then(
      (value) {
        if (!mounted) return;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AuthCheckScreen()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.read(newsFSProvider.notifier).newsData();
    ref.read(storeFsDataProvider.notifier).loadStoreAllData();
    ref.read(localCartIntiProvider.notifier).loadIntiCartData();

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
