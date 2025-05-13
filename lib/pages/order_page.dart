import 'package:flutter/material.dart';
import 'package:wcycle_bd/widgets/reusable_widgets/back_custom_button.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackCustomButton(),
            ],
          ),
        ],
      ),
    );
  }
}
