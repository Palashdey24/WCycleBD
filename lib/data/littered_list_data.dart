import 'package:wcycle_bd/data/recycable_price_data.dart';
import 'package:wcycle_bd/model/littered_list_model.dart';

enum Wastecat {
  papers,
  plastics,
  wood,
  metals,
  glass,
  compositeMaterials,
  ceramics,
  textiles,
  other
}

final litteredListData = [
  LitteredListModel(
      ltTittle: "Wasted on Found",
      ltLevel: ImapctLevel.medium,
      ltWCat: [
        Wastecat.wood.name,
        Wastecat.glass.name,
        Wastecat.plastics.name,
        Wastecat.other.name
      ],
      address: "New/471,University Road,Arefin Nagar",
      division: "Chattogram",
      villMetro: "Arefin Nagar",
      thana: "Baizid Bostami",
      ward: "5 No",
      ltSrc: "assets/metalfond.jpg"),
  LitteredListModel(
      ltTittle: "Industrial Wasted",
      ltLevel: ImapctLevel.high,
      ltWCat: [
        Wastecat.plastics.name,
        Wastecat.other.name,
        Wastecat.compositeMaterials.name
      ],
      address: "Near Megha Community Center, Chakrashala",
      division: "Chattogram",
      villMetro: "Chakrashala",
      thana: "Patiya",
      ward: "3 No",
      ltSrc: "assets/industrialGarbage.jpg"),
  LitteredListModel(
      ltTittle: "Metal on Road",
      ltLevel: ImapctLevel.low,
      ltWCat: [
        Wastecat.metals.name,
      ],
      address: "BahadharHat Khaca Bazar,Bahadharhat",
      division: "Chattogram",
      villMetro: "Bahadharhat",
      thana: "Chandgaon",
      ward: "4 No",
      ltSrc: 'assets/metal-field.jpg'),
  LitteredListModel(
      ltTittle: "Industrial Wasted",
      ltLevel: ImapctLevel.high,
      ltWCat: [
        Wastecat.plastics.name,
        Wastecat.other.name,
        Wastecat.compositeMaterials.name
      ],
      address: "Near Megha Community Center, Chakrashala",
      division: "Chattogram",
      villMetro: "Chakrashala",
      thana: "Patiya",
      ward: "3 No",
      ltSrc: "assets/industrialGarbage.jpg"),
  LitteredListModel(
      ltTittle: "Industrial Wasted",
      ltLevel: ImapctLevel.high,
      ltWCat: [
        Wastecat.plastics.name,
        Wastecat.other.name,
        Wastecat.compositeMaterials.name
      ],
      address: "Near Megha Community Center, Chakrashala",
      division: "Chattogram",
      villMetro: "Chakrashala",
      thana: "Patiya",
      ward: "3 No",
      ltSrc: 'assets/industrialGarbage.jpg'),
  LitteredListModel(
      ltTittle: "Metal on Road",
      ltLevel: ImapctLevel.low,
      ltWCat: [
        Wastecat.metals.name,
      ],
      address: "BahadharHat Khaca Bazar",
      division: "Chattogram",
      villMetro: "Bahadharhat",
      thana: "Chandgaon",
      ward: "4 No",
      ltSrc: 'assets/metal-field.jpg'),
];
