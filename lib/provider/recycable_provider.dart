import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd/data/recycable_price_data.dart';
import 'package:wcycle_bd/model/recyclable_list_model.dart';

class RecycableProviderNotifier extends StateNotifier<RecyclableListModel> {
  RecycableProviderNotifier()
      : super(const RecyclableListModel(
            rcName: "", rcImpact: ImapctLevel.high, rcPrice: 0, imgRsc: ""));

  void onChange(RecyclableListModel rcModel) {
    state = rcModel;
    log(5);
  }
}

final recycableProvider =
    StateNotifierProvider<RecycableProviderNotifier, RecyclableListModel>(
  (ref) {
    return RecycableProviderNotifier();
  },
);
