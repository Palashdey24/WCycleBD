class RecycleProductModel {
  RecycleProductModel({
    required this.impactLevel,
    required this.productImage,
    required this.productOnline,
    required this.shopID,
    required this.productPrice,
    required this.productName,
    required this.productID,
    this.quantity,
  });

  late final String impactLevel;
  late final String productImage;
  late final bool productOnline;
  late final String shopID;
  late final double productPrice;
  late final String productName;
  final String productID;
  late final int? quantity;

  RecycleProductModel.fromJson(Map<String, dynamic> json, this.productID) {
    impactLevel = json['impactLevel'] ?? "N/A";
    productImage = json['productImage'] ?? "N/A";
    productOnline = json['productOnline'] ?? "N/A";
    shopID = json['shopID'] ?? "N/A";
    productPrice = json['productPrice'] ?? "N/A";
    productName = json['productName'] ?? "N/A";
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['impactLevel'] = impactLevel;
    data['productImage'] = productImage;
    data['productOnline'] = productOnline;
    data['shopID'] = shopID;
    data['productPrice'] = productPrice;
    data['productName'] = productName;
    data['quantity'] = quantity;
    return data;
  }

  Map<String, dynamic> toJsonWithId() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['impactLevel'] = impactLevel;
    data['productImage'] = productImage;
    data['productOnline'] = productOnline;
    data['shopID'] = shopID;
    data['productPrice'] = productPrice;
    data['productName'] = productName;
    data['quantity'] = quantity;
    data['productID'] = productID;
    return data;
  }

  RecycleProductModel copyWith(
          {String? impactLevel,
          String? productImage,
          bool? productOnline,
          String? shopID,
          double? productPrice,
          String? productName,
          String? productID,
          int? quantity}) =>
      RecycleProductModel(
        impactLevel: impactLevel ?? this.impactLevel,
        productImage: productImage ?? this.productImage,
        productOnline: productOnline ?? this.productOnline,
        shopID: shopID ?? this.shopID,
        productPrice: productPrice ?? this.productPrice,
        productName: productName ?? this.productName,
        productID: productID ?? this.productID,
        quantity: quantity ?? this.quantity,
      );
}
