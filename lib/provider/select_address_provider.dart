import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/model/address_model.dart';

class SelectAddressProviderNotifier extends StateNotifier<List<AddressModel>> {
  SelectAddressProviderNotifier() : super([AddressModel()]);

  Future<void> updateSelectedAddress(AddressModel addressModel) async {
    state = [addressModel];
  }
}

final selectedAddressProvider =
    StateNotifierProvider<SelectAddressProviderNotifier, List<AddressModel>>(
        (ref) {
  return SelectAddressProviderNotifier();
});
