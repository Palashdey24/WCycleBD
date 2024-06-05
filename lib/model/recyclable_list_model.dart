import 'package:wcycle_bd/data/recycable_price_data.dart';

class RecyclableListModel {
  const RecyclableListModel(
      {required this.rcName,
      required this.rcImpact,
      required this.rcPrice,
      required this.imgRsc});

  final String rcName;
  final ImapctLevel rcImpact;
  final double rcPrice;
  final String imgRsc;
}
