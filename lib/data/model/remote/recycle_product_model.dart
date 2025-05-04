class RecycleProductModel {
  RecycleProductModel({
    required this.impactLevel,
    required this.productImage,
    required this.productOnline,
    required this.shopID,
    required this.productPrice,
    required this.productName,
    required this.productID,
  });

  late final String impactLevel;
  late final String productImage;
  late final bool productOnline;
  late final String shopID;
  late final double productPrice;
  late final String productName;
  final String productID;

  RecycleProductModel.fromJson(Map<String, dynamic> json, this.productID) {
    impactLevel = json['impactLevel'] ?? "N/A";
    productImage = json['productImage'] ?? "N/A";
    productOnline = json['productOnline'] ?? "N/A";
    shopID = json['shopID'] ?? "N/A";
    productPrice = json['productPrice'] ?? "N/A";
    productName = json['productName'] ?? "N/A";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['impactLevel'] = impactLevel;
    data['productImage'] = productImage;
    data['productOnline'] = productOnline;
    data['shopID'] = shopID;
    data['productPrice'] = productPrice;
    data['productName'] = productName;
    return data;
  }
}
