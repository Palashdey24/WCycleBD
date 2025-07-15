import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/device_size.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/pages/add/configure_address.dart';
import 'package:wcycle_bd/provider/user_address_provider.dart';
import 'package:wcycle_bd/widgets/address/address_item.dart';

class AddressBookPage extends ConsumerWidget {
  const AddressBookPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAddress = ref.watch(userAddressDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Address Book"),
        centerTitle: true,
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ConfigureAddress(),
              )),
          child: const Text("Add New Address")),
      body: userAddress.isEmpty
          ? Center(
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Gap(DeviceSize.getDeviceHeight(context) * 0.1),
                  Image.asset(
                    "assets/no_address_icon.png",
                  ),
                  Text(
                    "No Address Found",
                    style: FontHelper()
                        .bodyMedium(context)
                        .copyWith(color: Colors.deepOrangeAccent),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: userAddress.length,
              itemBuilder: (context, index) {
                return AddressItem(
                  addressModel: userAddress[index],
                );
              },
            ),
    );
  }
}
