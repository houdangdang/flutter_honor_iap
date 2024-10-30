part of flutter_honor_iap;

/// Request information of the createPurchaseIntent API.
class PurchaseIntentReq extends BaseReq {
  int priceType;
  String productId;
  String? developerPayload;
  String? signatureAlgorithm;
  bool? autoConsume;
  int? sandboxTest;

  PurchaseIntentReq({
    required this.priceType,
    required this.productId,
    this.developerPayload,
    this.signatureAlgorithm,
    this.autoConsume,
    this.sandboxTest,
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
        autoConsume: json['autoConsume'],
        sandboxTest: json['sandboxTest'],
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'priceType': priceType,
      'productId': productId,
      'developerPayload': developerPayload,
      'reservedInfor': reservedInfor,
      'signatureAlgorithm': signatureAlgorithm,
      'autoConsume': autoConsume,
      'sandboxTest': sandboxTest,
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
        signatureAlgorithm == other.signatureAlgorithm &&
        autoConsume == other.autoConsume &&
        sandboxTest == other.sandboxTest;
  }

  @override
  int get hashCode => Object.hash(
        priceType,
        productId,
        developerPayload,
        reservedInfor,
        signatureAlgorithm,
        autoConsume,
        sandboxTest,
      );
}
