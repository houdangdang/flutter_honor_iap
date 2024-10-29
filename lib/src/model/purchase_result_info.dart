part of flutter_honor_iap;

/// Payment result information.
class PurchaseResultInfo {
  String? returnCode;
  InAppPurchaseData? inAppPurchaseData;
  String? inAppDataSignature;
  String? errMsg;
  String? signatureAlgorithm;
  final String rawValue;

  PurchaseResultInfo({
    required this.rawValue,
    this.inAppDataSignature,
    this.inAppPurchaseData,
    this.returnCode,
    this.errMsg,
    this.signatureAlgorithm,
  });

  factory PurchaseResultInfo.fromJson(String str) =>
      PurchaseResultInfo.fromMap(str);

  String toJson() => json.encode(toMap());

  factory PurchaseResultInfo.fromMap(String source) {
    final jsonMap = json.decode(source) as Map<String, dynamic>;
    return PurchaseResultInfo(
      returnCode: jsonMap['returnCode']?.toString(),
      inAppPurchaseData: jsonMap['inAppPurchaseData'] != null
          ? InAppPurchaseData.fromJson(jsonMap['inAppPurchaseData'])
          : null,
      inAppDataSignature: jsonMap['inAppDataSignature'],
      errMsg: jsonMap['errMsg'],
      signatureAlgorithm: jsonMap['signatureAlgorithm'],
      rawValue: source,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'returnCode': returnCode,
      'inAppPurchaseData': inAppPurchaseData?.toJson(),
      'inAppDataSignature': inAppDataSignature,
      'errMsg': errMsg,
      'signatureAlgorithm': signatureAlgorithm,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;

    return other is PurchaseResultInfo &&
        returnCode == other.returnCode &&
        inAppPurchaseData == other.inAppPurchaseData &&
        inAppDataSignature == other.inAppDataSignature &&
        errMsg == other.errMsg &&
        signatureAlgorithm == other.signatureAlgorithm;
  }

  @override
  int get hashCode => Object.hash(
        returnCode,
        inAppPurchaseData,
        inAppDataSignature,
        errMsg,
        signatureAlgorithm,
      );
}
