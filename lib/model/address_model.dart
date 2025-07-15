class AddressModel {
  String? zip;
  bool? isDefault;
  String? apt;
  String? city;
  String? street;
  String? contactNumber;
  String? name;
  String? userId;
  double? long;
  double? lat;
  String? mapAddress;
  String? addressID;

  AddressModel(
      {this.zip,
      this.isDefault,
      this.apt,
      this.city,
      this.street,
      this.contactNumber,
      this.name,
      this.userId,
      this.long,
      this.lat,
      this.mapAddress});

  AddressModel.fromJson(Map<String, dynamic> json, {this.addressID}) {
    zip = json['zip'];
    isDefault = json['isDefault'];
    apt = json['apt'];
    city = json['city'];
    street = json['street'];
    contactNumber = json['contactNumber'];
    name = json['name'];
    userId = json['userId'];
    long = json['long'];
    lat = json['lat'];
    mapAddress = json['mapAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['zip'] = zip;
    data['isDefault'] = isDefault;
    data['apt'] = apt;
    data['city'] = city;
    data['street'] = street;
    data['contactNumber'] = contactNumber;
    data['name'] = name;
    data['userId'] = userId;
    data['long'] = long;
    data['lat'] = lat;
    data['mapAddress'] = mapAddress;
    return data;
  }
}
