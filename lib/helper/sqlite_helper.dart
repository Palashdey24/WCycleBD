import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wcycle_bd/data/model/local/cart_database.dart';
import 'package:wcycle_bd/data/model/local/wishlist_database.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/pages/cart_page.dart';

class SQLiteHelper {
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

  // From This below functions are for Cart add remove on Sql

  static void addCartSql(
      BuildContext context,
      String randomId,
      String storeId,
      String productId,
      int quantity,
      String userId,
      bool inCart,
      String? previousId) async {
    DialogsHelper.showProgressBar(context);
    if (inCart) {
      removeCartItem(previousId!, context);
    }

    final db = await CartDatabase.getDatabase();

    await db.insert("carts", {
      "id": randomId,
      "userID": userId,
      "productId": productId,
      "storeId": storeId,
      "quantity": quantity
    }).then(
      (value) {
        if (value >= 1 && context.mounted) {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ));
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

  static void removeCartItem(String id, BuildContext context) async {
    DialogsHelper.showProgressBar(context);
    final db = await CartDatabase.getDatabase();
    await db
        .delete("carts", where: "productId = ?", whereArgs: [id]).then((value) {
      if (value >= 1 && context.mounted) {
        Navigator.pop(context);
        DialogsHelper.showMessage(context, "Remove to carts");
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

  static void updateCartItem(
      String id, BuildContext context, int quantity) async {
    DialogsHelper.showProgressBar(context);
    final db = await CartDatabase.getDatabase();
    await db.rawUpdate("UPDATE carts SET quantity = ? WHERE id = ?",
        [quantity, id]).then((value) {
      if (value >= 1 && context.mounted) {
        Navigator.pop(context);
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
