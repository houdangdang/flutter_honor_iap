part of '../../flutter_honor_iap.dart';

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
  List<String> skuIds;

  /// Creates a [ProductInfoReq] object.
  ProductInfoReq({
    required this.priceType,
    required this.skuIds,
    String? reservedInfor,
  }) : super(reservedInfor: reservedInfor);

  /// Creates a [ProductInfoReq] object from a JSON string.
  factory ProductInfoReq.fromJson(String str) =>
      ProductInfoReq.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductInfoReq.fromMap(Map<String, dynamic> json) => ProductInfoReq(
        priceType: json['priceType'],
        skuIds: json['skuIds'].cast<String>(),
        reservedInfor: json['reservedInfor'],
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'priceType': priceType,
      'skuIds': skuIds,
      'reservedInfor': reservedInfor,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is ProductInfoReq &&
        this.priceType == other.priceType &&
        listEquals(this.skuIds, other.skuIds) &&
        this.reservedInfor == other.reservedInfor;
  }

  @override
  int get hashCode => Object.hash(
        priceType,
        Object.hashAll(skuIds),
        reservedInfor,
      );
}
