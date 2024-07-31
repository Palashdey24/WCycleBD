import 'package:flutter/material.dart';
import 'package:wcycle_bd/widgets/cart_page/cart_list_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return const CartListItem();
      },
    );
  }
}
