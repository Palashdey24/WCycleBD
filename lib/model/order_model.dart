class OrderModel {
  OrderModel({
    this.metaDatas,
    required this.address,
    required this.totalPrice,
    required this.storeId,
    this.status,
    this.products,
  });
  //final List<MetaData>? metaData;
  late final Address address;
  late final double totalPrice;
  late final String storeId;
  List<Status>? status;
  List<Products>? products;
  List<MetaData>? metaDatas;
  String? orderID;

  OrderModel.fromJson(Map<String, dynamic> json, {this.orderID}) {
    metaDatas =
        List.from(json['metaData']).map((e) => MetaData.fromJson(e)).toList();
    address = Address.fromJson(json['address']);
    totalPrice = json['totalPrice'];
    storeId = json['storeId'];
    status = List.from(json['status']).map((e) => Status.fromJson(e)).toList();
    products =
        List.from(json['products']).map((e) => Products.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    // _data['metaData'] = metaData?.map((e) => e.toJson()).toList() ?? [];
    _data['address'] = address.toJson();
    _data['totalPrice'] = totalPrice;
    _data['storeId'] = storeId;
    // _data['status'] = status?.map((e) => e.toJson()).toList() ?? [];
    // _data['products'] = products?.map((e) => e.toJson()).toList() ?? [];
    return _data;
  }
}

class MetaData {
  MetaData({
    required this.metaName,
    required this.metaData,
  });
  late final String metaName;
  late final String metaData;

  MetaData.fromJson(Map<String, dynamic> json) {
    metaData = json['metaData'];
    metaName = json['metaName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['metaData'] = metaData;
    _data['metaName'] = metaName;
    return _data;
  }
}

class Address {
  Address({
    required this.zip,
    required this.isDefault,
    required this.apt,
    required this.city,
    required this.street,
    required this.contactNumber,
    required this.name,
    required this.userId,
    required this.long,
    required this.lat,
    required this.mapAddress,
  });
  late final String zip;
  late final bool isDefault;
  late final String apt;
  late final String city;
  late final String street;
  late final String contactNumber;
  late final String name;
  late final String userId;
  late final double long;
  late final double lat;
  late final String mapAddress;

  Address.fromJson(Map<String, dynamic> json) {
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
    final _data = <String, dynamic>{};
    _data['zip'] = zip;
    _data['isDefault'] = isDefault;
    _data['apt'] = apt;
    _data['city'] = city;
    _data['street'] = street;
    _data['contactNumber'] = contactNumber;
    _data['name'] = name;
    _data['userId'] = userId;
    _data['long'] = long;
    _data['lat'] = lat;
    _data['mapAddress'] = mapAddress;
    return _data;
  }
}

class Status {
  Status({
    required this.Time,
    required this.status,
  });
  late final String Time;
  late final String status;

  Status.fromJson(Map<String, dynamic> json) {
    Time = json['Time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Time'] = Time;
    _data['status'] = status;
    return _data;
  }
}

class Products {
  Products({
    required this.impactLevel,
    required this.quantity,
    required this.productImage,
    required this.productID,
    required this.productOnline,
    required this.shopID,
    required this.productName,
    required this.productPrice,
  });
  late final String impactLevel;
  late final int quantity;
  late final String productImage;
  late final String productID;
  late final bool productOnline;
  late final String shopID;
  late final String productName;
  late final double productPrice;

  Products.fromJson(Map<String, dynamic> json) {
    impactLevel = json['impactLevel'];
    quantity = json['quantity'];
    productImage = json['productImage'];
    productID = json['productID'];
    productOnline = json['productOnline'];
    shopID = json['shopID'];
    productName = json['productName'];
    productPrice = json['productPrice'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['impactLevel'] = impactLevel;
    _data['quantity'] = quantity;
    _data['productImage'] = productImage;
    _data['productID'] = productID;
    _data['productOnline'] = productOnline;
    _data['shopID'] = shopID;
    _data['productName'] = productName;
    _data['productPrice'] = productPrice;
    return _data;
  }
}
