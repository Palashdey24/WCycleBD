import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/pages/add/configure_address.dart';
import 'package:wcycle_bd/provider/select_address_provider.dart';
import 'package:wcycle_bd/provider/user_address_provider.dart';
import 'package:wcycle_bd/widgets/address/address_item.dart';

class OrderAddressUi extends ConsumerWidget {
  const OrderAddressUi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAddress = ref.read(userAddressDataProvider);

    //* selected address for order
    final selectedAddress = ref.watch(selectedAddressProvider);

    void showAddressList() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: normalGap),
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    backgroundColor: Colors.red.withValues(alpha: 0.3),
                    child: const FaIcon(
                      FontAwesomeIcons.solidHandPointLeft,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: normalGap),
                    itemCount: userAddress.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          DialogsHelper.showMessage(
                              context, "Address Selected");
                          ref
                              .read(selectedAddressProvider.notifier)
                              .updateSelectedAddress(userAddress[index])
                              .whenComplete(
                            () {
                              if (!context.mounted) return;
                              Navigator.pop(context);
                            },
                          );
                        },
                        child: Card(
                          color: selectedAddress[0].addressID ==
                                  userAddress[index].addressID
                              ? Colors.black
                              : Colors.white,
                          shape: Border.all(
                              color: selectedAddress[0].addressID ==
                                      userAddress[index].addressID
                                  ? Colors.green
                                  : Colors.amber,
                              width: 2),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: AddressItem(
                            addressModel: userAddress[index],
                            isCartAddressItem: true,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      padding: const EdgeInsets.symmetric(horizontal: normalGap, vertical: 5),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Address",
                  style: FontHelper()
                      .bodyMedium(context)
                      .copyWith(color: Colors.white)),
              TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConfigureAddress(),
                    )),
                child: Text("New Address",
                    style: FontHelper()
                        .bodyMedium(context)
                        .copyWith(color: Colors.white)),
              ),
            ],
          ),
          Card(
            color: Colors.white,
            shape: Border.all(color: Colors.green, width: 2),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: AddressItem(
              addressModel: selectedAddress[0],
              isCartAddressItem: true,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => showAddressList(),
              child: Text("More Address",
                  style: FontHelper()
                      .bodySmall(context)
                      .copyWith(color: Colors.yellow)),
            ),
          ),
        ],
      ),
    );
  }
}
