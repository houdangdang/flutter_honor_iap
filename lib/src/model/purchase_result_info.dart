part of flutter_honor_iap;

/// Payment result information.
class PurchaseResultInfo {
  String? returnCode;
  String? inAppDataSignature;
  String? errMsg;
  String? signatureAlgorithm;
  ConsumePurchaseData? consumeData;
  String? agreementNo;
  String? iapOrderNo;
  String? purchaseToken;

  PurchaseResultInfo({
    this.inAppDataSignature,
    this.returnCode,
    this.errMsg,
    this.signatureAlgorithm,
    this.consumeData,
    this.agreementNo,
    this.iapOrderNo,
    this.purchaseToken,
  });

  factory PurchaseResultInfo.fromJson(String str) =>
      PurchaseResultInfo.fromMap(str);

  String toJson() => json.encode(toMap());

  factory PurchaseResultInfo.fromMap(String source) {
    final jsonMap = json.decode(source) as Map<String, dynamic>;
    return PurchaseResultInfo(
      returnCode: jsonMap['returnCode']?.toString(),
      inAppDataSignature: jsonMap['inAppDataSignature'],
      errMsg: jsonMap['errMsg'],
      signatureAlgorithm: jsonMap['signatureAlgorithm'],
      consumeData: jsonMap['consumeData'] != null
          ? ConsumePurchaseData.fromJson(jsonMap['consumeData'])
          : null,
      agreementNo: jsonMap['agreementNo'],
      iapOrderNo: jsonMap['iapOrderNo'],
      purchaseToken: jsonMap['purchaseToken'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'returnCode': returnCode,
      'inAppDataSignature': inAppDataSignature,
      'errMsg': errMsg,
      'signatureAlgorithm': signatureAlgorithm,
      'consumeData': consumeData?.toJson(),
      'agreementNo': agreementNo,
      'iapOrderNo': iapOrderNo,
      'purchaseToken': purchaseToken,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;

    return other is PurchaseResultInfo &&
        returnCode == other.returnCode &&
        inAppDataSignature == other.inAppDataSignature &&
        errMsg == other.errMsg &&
        signatureAlgorithm == other.signatureAlgorithm &&
        consumeData == other.consumeData &&
        agreementNo == other.agreementNo &&
        iapOrderNo == other.iapOrderNo &&
        purchaseToken == other.purchaseToken;
  }

  @override
  int get hashCode => Object.hash(
        returnCode,
        inAppDataSignature,
        errMsg,
        signatureAlgorithm,
        consumeData,
        agreementNo,
        iapOrderNo,
        purchaseToken,
      );
}
