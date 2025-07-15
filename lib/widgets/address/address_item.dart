import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/helper/firebase_helper.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/model/address_model.dart';
import 'package:wcycle_bd/pages/add/configure_address.dart';
import 'package:wcycle_bd/provider/user_address_provider.dart';

class AddressItem extends ConsumerWidget {
  const AddressItem({
    super.key,
    required this.addressModel,
    this.isCartAddressItem,
  });

  final AddressModel addressModel;

  final bool? isCartAddressItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fullAddress =
        "${addressModel.street} ${addressModel.apt}, ${addressModel.city}, ${addressModel.zip}";

    void deleteAddress() async {
      final fsRef = FirebaseHelper.fireStore
          .collection("userAddress")
          .doc(addressModel.addressID);

      showCupertinoDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete Address",
                style: FontHelper()
                    .bodyMedium(context)
                    .copyWith(color: Colors.red)),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: FontHelper().bodySmall(context),
                  )),
              ElevatedButton(
                  onPressed: () {
                    DialogsHelper.showProgressBar(context);
                    fsRef.delete().then(
                      (value) async {
                        await ref
                            .read(userAddressDataProvider.notifier)
                            .fetchData();
                        if (!context.mounted) return;
                        DialogsHelper.showMessage(
                            context, "Address Deleted Successfully");
                        Navigator.of(context)
                          ..pop()
                          ..pop();
                        return;
                      },
                    ).catchError((error) {
                      if (!context.mounted) return;
                      DialogsHelper.showMessage(
                          context, "Something went wrong $error");
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                      return;
                    });
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  },
                  child: Text(
                    "Delete",
                    style: FontHelper().bodySmall(context),
                  )),
            ],
            content: Text(
              "Are you sure you want to delete this address?",
              style: FontHelper().bodySmall(context),
            ),
          );
        },
      );

/*      showDialog(
        barrierColor: Colors.black,
        context: context,
        builder: (context) {
          return Card(
            child: Flex(
              direction: Axis.vertical,
              spacing: csGap,
              children: [
                Text(
                  "Are you sure you want to delete this address?",
                  style: FontHelper().bodySmall(context),
                ),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: FontHelper().bodySmall(context),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          fsRef.delete().then(
                            (value) {
                              ref
                                  .read(userAddressDataProvider.notifier)
                                  .fetchData();
                              if (!context.mounted) return;
                              DialogsHelper.showMessage(
                                  context, "Address Deleted Successfully");
                              Navigator.of(context).pop();
                            },
                          ).catchError((error) {
                            if (!context.mounted) return;
                            DialogsHelper.showMessage(
                                context, "Something went wrong $error");
                            Navigator.pop(context);
                            return;
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Delete",
                          style: FontHelper().bodySmall(context),
                        )),
                  ],
                )
              ],
            ),
          );
        },
      );*/
    }

    Widget addressItemBody() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            if (isCartAddressItem == null)
              IconButton(
                  onPressed: deleteAddress,
                  icon: const FaIcon(
                    FontAwesomeIcons.solidTrashCan,
                    color: Colors.orange,
                  )),
            Expanded(
                child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  addressModel.name!,
                  style: FontHelper().bodySmall(context),
                ),
                Text(
                  addressModel.mapAddress!,
                  style: FontHelper().bodySmall(context).copyWith(
                      color: Colors.grey, fontWeight: FontWeight.normal),
                ),
                Text(
                  fullAddress,
                  style: FontHelper().bodySmall(context),
                ),
                Text(
                  addressModel.contactNumber!,
                  style: FontHelper().bodySmall(context).copyWith(
                      color: Colors.grey, fontWeight: FontWeight.normal),
                ),
              ],
            )),
            if (isCartAddressItem == null)
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfigureAddress(
                        title: "Edit Address",
                        address: addressModel,
                      ),
                    )),
                child: Text(
                  "Edit",
                  style: FontHelper().bodySmall(context),
                ),
              ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        if (isCartAddressItem == null)
          Card(
            shape: Border.all(
                color: addressModel.isDefault == true
                    ? Colors.purpleAccent.shade100
                    : Colors.black,
                width: 2),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: addressItemBody(),
          ),
        if (isCartAddressItem != null) addressItemBody(),
        if (addressModel.isDefault == true)
          Positioned(
              right: 5,
              child: Card(
                color: Colors.blueGrey,
                shape: const BeveledRectangleBorder(
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.elliptical(5, 5)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text("Default",
                      style: FontHelper()
                          .bodySmall(context)
                          .copyWith(color: Colors.white)),
                ),
              ))
      ],
    );
  }
}
