import 'package:flutter/material.dart';
import 'package:wcycle_bd/widgets/loading_widget.dart';

class DialogsHelper {
  void showMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
    ));
  }

  void removeMessage(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  void showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return const Center(child: LoadingWidgets());
      },
    );
  }
}
