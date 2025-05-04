class StoreModel {
  StoreModel({
    required this.phoneNumber,
    required this.storeAddress,
    required this.locations,
    required this.storeName,
    required this.docUri,
    required this.id,
    required this.logoUri,
    required this.storeStatus,
    required this.email,
    required this.storeBin,
    this.rating,
    this.totalRated,
  });
  late final String phoneNumber;
  late final String storeAddress;
  late final Locations locations;
  late final String storeName;
  late final String docUri;
  late final String id;
  late final String logoUri;
  late final String storeStatus;
  late final String email;
  late final String storeBin;
  late final int? rating;
  late final int? totalRated;

  StoreModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'] ?? "N?A";
    storeAddress = json['storeAddress'] ?? "N?A";
    locations = Locations.fromJson(json['locations']);
    storeName = json['storeName'] ?? "N?A";
    docUri = json['docUri'] ?? "N?A";
    id = json['id'] ?? "N?A";
    logoUri = json['logoUri'] ?? "N?A";
    storeStatus = json['storeStatus'] ?? "N?A";
    email = json['email'] ?? "N?A";
    storeBin = json['storeBin'] ?? "N?A";
    rating = json['rating'] ?? 0;
    totalRated = json['totalRated'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    data['storeAddress'] = storeAddress;
    data['locations'] = locations.toJson();
    data['storeName'] = storeName;
    data['docUri'] = docUri;
    data['id'] = id;
    data['logoUri'] = logoUri;
    data['storeStatus'] = storeStatus;
    data['email'] = email;
    data['storeBin'] = storeBin;
    data['rating'] = rating;
    data['totalRated'] = totalRated;
    return data;
  }
}

class Locations {
  Locations({
    required this.address,
    required this.lon,
    required this.lat,
  });
  late final String address;
  late final double lon;
  late final double lat;

  Locations.fromJson(Map<String, dynamic> json) {
    address = json['address'] ?? "N?A";
    lon = json['lon'] ?? 0;
    lat = json['lat'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['address'] = address;
    data['lon'] = lon;
    data['lat'] = lat;
    return data;
  }
}
