import 'package:wcycle_bd/data/recycable_price_data.dart';

class LitteredListModel {
  const LitteredListModel(
      {required this.ltTittle,
      required this.ltLevel,
      required this.ltWCat,
      required this.address,
      required this.division,
      required this.villMetro,
      required this.thana,
      required this.ltSrc,
      required this.ward});

  final String ltTittle;
  final ImapctLevel ltLevel;
  final List<String> ltWCat;
  final String address;
  final String division;
  final String villMetro;
  final String thana;
  final String ward;
  final String ltSrc;
}
