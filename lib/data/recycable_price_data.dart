import 'package:wcycle_bd/model/recyclable_list_model.dart';

enum ImapctLevel { high, mediumHigh, lowHigh, medium, low, normal }

final recyclable = [
  const RecyclableListModel(
      rcName: "iron",
      rcImpact: ImapctLevel.low,
      rcPrice: 35.00,
      imgRsc: "metal-iron.jpg"),
  const RecyclableListModel(
      rcName: "Plastic",
      rcImpact: ImapctLevel.high,
      rcPrice: 10.00,
      imgRsc: "plastic_bottle.png"),
  const RecyclableListModel(
      rcName: "iron",
      rcImpact: ImapctLevel.low,
      rcPrice: 35.00,
      imgRsc: "metal-iron.jpg"),
  const RecyclableListModel(
      rcName: "Plastic",
      rcImpact: ImapctLevel.high,
      rcPrice: 10.00,
      imgRsc: "plastic_bottle.png"),
];
