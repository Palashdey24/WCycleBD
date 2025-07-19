import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd/helper/dialogs_helper.dart';
import 'package:wcycle_bd/helper/firebase_helper.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/address_model.dart';
import 'package:wcycle_bd/provider/current_user_fs_provider.dart';
import 'package:wcycle_bd/provider/user_address_provider.dart';
import 'package:wcycle_bd/widgets/address/address_locations_ui.dart';
import 'package:wcycle_bd/widgets/address/card_for_form.dart';
import 'package:wcycle_bd/widgets/form_simple_texts.dart';

class ConfigureAddress extends ConsumerWidget {
  const ConfigureAddress({super.key, this.address, this.title});

  final String? title;
  final AddressModel? address;

  static String? commonValidator(String? value, String? errorMsg) {
    if (value == null || value.trim().isEmpty || value.trim().length < 3) {
      return errorMsg;
    }
    return null;
  }

  static String? phoneValidator(String? value, String? errorMsg) {
    if (value == null || value.trim().isEmpty || value.trim().length < 9) {
      return errorMsg;
    }
    return null;
  }

  void addAddress(Map<String, dynamic> addressData, BuildContext context,
      WidgetRef ref) async {
    final addressAdd = await FirebaseHelper.upFirestoreData(
        addressData, "userAddress", context);

    if (addressAdd != null) {
      if (!context.mounted) return;
      await defaultUpdate(
          context: context, currentDefault: addressData['isDefault']);
      ref.read(userAddressDataProvider.notifier).fetchData();
      if (!context.mounted) return;
      Navigator.of(context)
        ..pop()
        ..pop();
    }
  }

  void editAddress(Map<String, dynamic> addressData, BuildContext context,
      WidgetRef ref) async {
    final fsRef = FirebaseHelper.fireStore.collection("userAddress");

    //* Default check and updated in separated Function
    final defaultChange = await defaultUpdate(
        context: context, currentDefault: addressData['isDefault']);

    if (defaultChange == false) return;
    await fsRef.doc(address!.addressID).update(addressData).then(
      (value) {
        ref.read(userAddressDataProvider.notifier).fetchData();
        if (!context.mounted) return;
        DialogsHelper.showMessage(context, "Address Updated Successfully");
        Navigator.of(context)
          ..pop()
          ..pop();
        return;
      },
    ).catchError((error) {
      if (!context.mounted) return;
      DialogsHelper.showMessage(context, "Something went wrong");
      Navigator.pop(context);
      return;
    });

    return;
  }

  Future<bool?> defaultUpdate(
      {required BuildContext context, bool? currentDefault}) async {
    final fsRef = FirebaseHelper.fireStore.collection("userAddress");
    final oldDefault = await fsRef
        .where("isDefault", isEqualTo: true)
        .where("userId", isEqualTo: FirebaseHelper.userId)
        .get();

    if (!context.mounted) return null;

    if (oldDefault.docs.isNotEmpty) {
      String oldDefaultAddressId = oldDefault.docs[0].id;

      if (address != null && oldDefaultAddressId == address!.addressID) {
        DialogsHelper.showMessage(
            context, "Please choose another address as default");
        Navigator.pop(context);
        return false;
      } else if (currentDefault == true) {
        final fsRef = FirebaseHelper.fireStore
            .collection("userAddress")
            .doc(oldDefaultAddressId);

        fsRef.update({
          "isDefault": false,
        }).catchError((error) {
          if (!context.mounted) return;
          DialogsHelper.showMessage(context, "Something went wrong");
          Navigator.pop(context);
          return;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //* Google Map Data
    String? mapAddress = address?.mapAddress;
    double? mapLat = address?.lat;
    double? mapLong = address?.long;
    bool intiDefault = address?.isDefault ?? false;

    //* Address Data

    String? street;
    String? apt;
    String? city;
    String? zip;

    ValueNotifier<bool> isDefault = ValueNotifier(intiDefault);
    final formKey = GlobalKey<FormState>();

    final user = ref.read(currentUserdataProvider);

    String? userName = user.userName;
    String? phoneNumber = user.phoneNumber.substring(4);

    //* function for getting Map data from address_location_ui class
    void locationData(String? address, double? lat, double? long) {
      mapAddress = address;
      mapLat = lat;
      mapLong = long;
    }

    void onSaveAddress() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        if (mapAddress != null && mapLat != 0 && mapLong != 0) {
          DialogsHelper.showProgressBar(context);

          final addressData = {
            "contactNumber": "+880$phoneNumber",
            "name": userName,
            "street": street,
            "apt": apt,
            "city": city,
            "zip": zip,
            "mapAddress": mapAddress,
            "lat": mapLat,
            "long": mapLong,
            "isDefault": isDefault.value,
            "userId": FirebaseHelper.userId,
          };

          if (address != null) {
            editAddress(addressData, context, ref);
            return;
          }
          addAddress(addressData, context, ref);
          return;
        }
        DialogsHelper.showMessage(context, "Please choose address from Google");
        return;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title ?? "Add New Address",
          style: FontHelper().bodyMedium(context),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            AddressLocationsUi(
              takeLocationsData: locationData,
              addressModel: address,
            ),
            CardForForm(
              cardWidgets: [
                FormSimpleTexts(
                  labelTxt: "Name *",
                  intial: address?.name ?? userName,
                  hint: "Contact Person Name",
                  txtInType: TextInputType.text,
                  validator: (value) =>
                      commonValidator(value, "Name is required"),
                  onSave: (String value) {
                    userName = value;
                  },
                ),
                Flex(
                  direction: Axis.horizontal,
                  spacing: 3,
                  children: [
                    Expanded(
                      flex: 1,
                      child: FormSimpleTexts(
                        labelTxt: "",
                        hint: "Code",
                        intial: "+880",
                        enabled: false,
                        txtInType: TextInputType.number,
                        validator: (_) {
                          return null;
                        },
                        onSave: (String value) {},
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: FormSimpleTexts(
                        labelTxt: "Number *",
                        intial:
                            address?.contactNumber?.substring(4) ?? phoneNumber,
                        hint: "Number",
                        maxLen: 10,
                        txtInType: TextInputType.number,
                        validator: (value) => phoneValidator(value,
                            "Valid Phone number is required with 10 digit"),
                        onSave: (String value) {
                          phoneNumber = value;
                        },
                      ),
                    ),
                  ],
                )
              ],
              title: 'Personal Information',
            ),
            const Gap(normalGap),
            CardForForm(
              title: "Address",
              cardWidgets: [
                FormSimpleTexts(
                  txtInType: TextInputType.text,
                  hint: "Street,House/Apartment/unit",
                  intial: address?.street,
                  validator: (value) =>
                      commonValidator(value, "Address is required"),
                  onSave: (value) {
                    street = value;
                  },
                ),
                FormSimpleTexts(
                  txtInType: TextInputType.text,
                  intial: address?.apt,
                  hint: "Apt,suit,unit etc (optional)",
                  validator: (_) {
                    return null;
                  },
                  onSave: (value) {
                    apt = value;
                  },
                ),
                FormSimpleTexts(
                  txtInType: TextInputType.text,
                  hint: "City*",
                  intial: address?.city,
                  validator: (value) =>
                      commonValidator(value, "City is required"),
                  onSave: (value) {
                    city = value;
                  },
                ),
                FormSimpleTexts(
                  txtInType: TextInputType.number,
                  hint: "Zip Code*",
                  intial: address?.zip,
                  validator: (value) => commonValidator(
                      value, "Zip code is required with 4 digits"),
                  onSave: (value) {
                    zip = value;
                  },
                ),
              ],
            ),
            const Gap(normalGap),
            Flex(
              direction: Axis.horizontal,
              children: [
                Text(
                  "Set as Default Delivery Address",
                  style: FontHelper().bodySmall(context),
                ),
                const Spacer(),
                ValueListenableBuilder(
                    valueListenable: isDefault,
                    builder: (context, value, child) {
                      return Switch(
                          value: isDefault.value,
                          onChanged: (value) {
                            isDefault.value = value;
                          });
                    }),
              ],
            ),
            const Gap(normalGap),
            ElevatedButton(onPressed: onSaveAddress, child: const Text("Save")),
            const Gap(largeGap),
          ],
        ),
      ),
    );
  }
}
