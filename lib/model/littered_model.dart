class LitteredModel {
  LitteredModel({
    required this.litteredAddress,
    required this.litteredVillMet,
    required this.litteredWasteMat,
    required this.litteredDivision,
    required this.productOnline,
    required this.litteredThana,
    required this.litteredTittle,
    required this.ltSrc,
    required this.createAdd,
    required this.litteredWard,
    required this.userId,
    required this.litteredImpactLevel,
  });
  late final String litteredAddress;
  late final String litteredVillMet;
  late final List<String> litteredWasteMat;
  late final String litteredDivision;
  late final bool productOnline;
  late final String litteredThana;
  late final String litteredTittle;
  late final String ltSrc;
  late final String createAdd;
  late final String litteredWard;
  late final String userId;
  late final String litteredImpactLevel;

  LitteredModel.fromJson(Map<String, dynamic> json) {
    litteredAddress = json['litteredAddress'];
    litteredVillMet = json['litteredVillMet'];
    litteredWasteMat = List.castFrom<dynamic, String>(json['litteredWasteMat']);
    litteredDivision = json['litteredDivision'];
    productOnline = json['productOnline'];
    litteredThana = json['litteredThana'];
    litteredTittle = json['litteredTittle'];
    ltSrc = json['ltSrc'];
    createAdd = json['createAdd'];
    litteredWard = json['litteredWard'];
    userId = json['userId'];
    litteredImpactLevel = json['litteredImpactLevel'];
  }

  Map<String, dynamic> toJson() {
    final ltData = <String, dynamic>{};
    ltData['litteredAddress'] = litteredAddress;
    ltData['litteredVillMet'] = litteredVillMet;
    ltData['litteredWasteMat'] = litteredWasteMat;
    ltData['litteredDivision'] = litteredDivision;
    ltData['productOnline'] = productOnline;
    ltData['litteredThana'] = litteredThana;
    ltData['litteredTittle'] = litteredTittle;
    ltData['ltSrc'] = ltSrc;
    ltData['createAdd'] = createAdd;
    ltData['litteredWard'] = litteredWard;
    ltData['userId'] = userId;
    ltData['litteredImpactLevel'] = litteredImpactLevel;
    return ltData;
  }
}
