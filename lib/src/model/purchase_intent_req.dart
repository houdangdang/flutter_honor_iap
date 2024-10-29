part of flutter_honor_iap;

/// Request information of the createPurchaseIntent API.
class PurchaseIntentReq extends BaseReq {
  int priceType;
  String productId;
  String? developerPayload;
  String? signatureAlgorithm;

  PurchaseIntentReq({
    required this.priceType,
    required this.productId,
    this.developerPayload,
    this.signatureAlgorithm,
    String? reservedInfor,
  }) : super(reservedInfor: reservedInfor);

  factory PurchaseIntentReq.fromJson(String str) =>
      PurchaseIntentReq.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PurchaseIntentReq.fromMap(Map<String, dynamic> json) =>
      PurchaseIntentReq(
        priceType: json['priceType'],
        productId: json['productId'],
        developerPayload: json['developerPayload'],
        reservedInfor: json['reservedInfor'],
        signatureAlgorithm: json['signatureAlgorithm'],
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'priceType': priceType,
      'productId': productId,
      'developerPayload': developerPayload,
      'reservedInfor': reservedInfor,
      'signatureAlgorithm': signatureAlgorithm,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;

    return other is PurchaseIntentReq &&
        priceType == other.priceType &&
        productId == other.productId &&
        developerPayload == other.developerPayload &&
        reservedInfor == other.reservedInfor &&
        signatureAlgorithm == other.signatureAlgorithm;
  }

  @override
  int get hashCode => Object.hash(
        priceType,
        productId,
        developerPayload,
        reservedInfor,
        signatureAlgorithm,
      );
}
