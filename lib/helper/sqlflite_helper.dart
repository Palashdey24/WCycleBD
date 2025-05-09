import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wcycle_bd/data/model/local/wishlist_database.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';

class SqlfliteHelper {
  static void addWishList(String productId, BuildContext context) async {
    DialogsHelper.showProgressBar(context);

    final db = await WishlistDatabase.getDatabase();

    await db.insert("wishlist", {
      "productId": productId,
    }).then(
      (value) {
        if (value >= 1 && context.mounted) {
          Navigator.pop(context);
          DialogsHelper.showMessage(context, "Added to wishlist");
          return;
        }
        if (!context.mounted) return;
        Navigator.pop(context);

        DialogsHelper.showMessage(context, "Something went wrong");
        return;
      },
    ).onError(
      (error, stackTrace) {
        if (!context.mounted) return;
        Navigator.pop(context);
        DialogsHelper.showMessage(context, "Something went wrong $error");
      },
    );

    return;
  }

  static void removeWishList(String productId, BuildContext context) async {
    DialogsHelper.showProgressBar(context);
    final db = await WishlistDatabase.getDatabase();
    await db.delete("wishlist",
        where: "productId = ?", whereArgs: [productId]).then((value) {
      if (value >= 1 && context.mounted) {
        Navigator.pop(context);
        DialogsHelper.showMessage(context, "Remove to wishlist");
        log("$value");
        return;
      }
      if (!context.mounted) return;
      Navigator.pop(context);

      DialogsHelper.showMessage(context, "Something went wrong");
      return;
    }).onError((error, stackTrace) {
      if (!context.mounted) return;
      Navigator.pop(context);
      DialogsHelper.showMessage(context, "Something went wrong $error");
    });
  }
}
