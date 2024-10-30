part of flutter_honor_iap;

/// Request information of the consumeOwnedPurchase API.
class ConsumeOwnedPurchaseReq extends BaseReq {
  String purchaseToken;
  String? developerChallenge;
  String? signatureAlgorithm;

  ConsumeOwnedPurchaseReq({
    required this.purchaseToken,
    this.developerChallenge,
    this.signatureAlgorithm,
    String? reservedInfor,
  }) : super(reservedInfor: reservedInfor);

  factory ConsumeOwnedPurchaseReq.fromJson(String str) =>
      ConsumeOwnedPurchaseReq.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConsumeOwnedPurchaseReq.fromMap(Map<String, dynamic> json) =>
      ConsumeOwnedPurchaseReq(
        purchaseToken: json['purchaseToken'],
        developerChallenge: json['developerChallenge'],
        signatureAlgorithm: json['signatureAlgorithm'],
        reservedInfor: json['reservedInfor'],
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'purchaseToken': purchaseToken,
      'developerChallenge': developerChallenge,
      'signatureAlgorithm': signatureAlgorithm,
      'reservedInfor': reservedInfor,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;

    return other is ConsumeOwnedPurchaseReq &&
        purchaseToken == other.purchaseToken &&
        developerChallenge == other.developerChallenge &&
        signatureAlgorithm == other.signatureAlgorithm &&
        reservedInfor == other.reservedInfor;
  }

  @override
  int get hashCode => Object.hash(
    purchaseToken,
    developerChallenge,
    signatureAlgorithm,
    reservedInfor,
  );
}
