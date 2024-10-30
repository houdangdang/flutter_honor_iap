part of flutter_honor_iap;

/// Request information of the obtainProductInfo API.
class ProductInfoReq extends BaseReq {
  /// Product type.
  ///
  /// - `0`: Consumable
  /// - `1`: Non-consumable
  /// - `2`: Auto-renewable subscription
  int priceType;

  /// ID list of products to be queried. Each product ID must exist and be unique in the current app.
  ///
  /// The product ID is the same as that you set when configuring product information in AppGallery Connect.
  List<String> productIds;

  /// Creates a [ProductInfoReq] object.
  ProductInfoReq({
    required this.priceType,
    required this.productIds,
    String? reservedInfor,
  }) : super(reservedInfor: reservedInfor);

  /// Creates a [ProductInfoReq] object from a JSON string.
  factory ProductInfoReq.fromJson(String str) =>
      ProductInfoReq.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductInfoReq.fromMap(Map<String, dynamic> json) => ProductInfoReq(
    priceType: json['priceType'],
    productIds: json['productIds'].cast<String>(),
    reservedInfor: json['reservedInfor'],
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'priceType': priceType,
      'productIds': productIds,
      'reservedInfor': reservedInfor,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;

    return other is ProductInfoReq &&
        priceType == other.priceType &&
        listEquals(productIds, other.productIds) &&
        reservedInfor == other.reservedInfor;
  }

  @override
  int get hashCode => Object.hash(
    priceType,
    Object.hashAll(productIds),
    reservedInfor,
  );
}
