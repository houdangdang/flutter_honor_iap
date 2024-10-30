part of flutter_honor_iap;

/// Details of a product.
List<ProductInfo> productInfoFromJson(String str) => List<ProductInfo>.from(json.decode(str).map((x) => ProductInfo.fromJson(x)));

String productInfoToJson(List<ProductInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductInfo {
  final String? country;
  final String? currency;
  final int? microPrice;
  final int? originalMicroPrice;
  final String? price;
  final String? productDesc;
  final String? productId;
  final String? productName;
  final int? productType;
  final int? status;
  final String? subGroupId;
  final int? subPeriod;
  final String? subPeriodUnit;

  ProductInfo({
    this.country,
    this.currency,
    this.microPrice,
    this.originalMicroPrice,
    this.price,
    this.productDesc,
    this.productId,
    this.productName,
    this.productType,
    this.status,
    this.subGroupId,
    this.subPeriod,
    this.subPeriodUnit,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
    country: json["country"],
    currency: json["currency"],
    microPrice: json["microPrice"],
    originalMicroPrice: json["originalMicroPrice"],
    price: json["price"],
    productDesc: json["productDesc"],
    productId: json["productId"],
    productName: json["productName"],
    productType: json["productType"],
    status: json["status"],
    subGroupId: json["subGroupId"],
    subPeriod: json["subPeriod"],
    subPeriodUnit: json["subPeriodUnit"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "currency": currency,
    "microPrice": microPrice,
    "originalMicroPrice": originalMicroPrice,
    "price": price,
    "productDesc": productDesc,
    "productId": productId,
    "productName": productName,
    "productType": productType,
    "status": status,
    "subGroupId": subGroupId,
    "subPeriod": subPeriod,
    "subPeriodUnit": subPeriodUnit,
  };
}
