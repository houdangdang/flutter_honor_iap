part of '../../flutter_honor_iap.dart';

/// Information returned when the consumeOwnedPurchase API is successfully called.
class ConsumeOwnedPurchaseResult {
  final ConsumePurchaseData? consumePurchaseData;
  final String? dataSignature;
  final String? errMsg;
  final String? returnCode;
  final Status? status;
  final String? signatureAlgorithm;
  final String rawValue;

  ConsumeOwnedPurchaseResult({
    required this.rawValue,
    this.consumePurchaseData,
    this.dataSignature,
    this.errMsg,
    this.returnCode,
    this.status,
    this.signatureAlgorithm,
  });

  factory ConsumeOwnedPurchaseResult.fromJson(String source) =>
      ConsumeOwnedPurchaseResult.fromMap(source);

  String toJson() => json.encode(toMap());

  factory ConsumeOwnedPurchaseResult.fromMap(String source) {
    final jsonMap = json.decode(source) as Map<String, dynamic>;
    return ConsumeOwnedPurchaseResult(
      consumePurchaseData: jsonMap['consumePurchaseData'] != null
          ? ConsumePurchaseData.fromJson(jsonMap['consumePurchaseData'])
          : null,
      dataSignature: jsonMap['dataSignature'],
      errMsg: jsonMap['errMsg'],
      returnCode: jsonMap['returnCode']?.toString(),
      status:
          jsonMap['status'] != null ? Status.fromMap(jsonMap['status']) : null,
      signatureAlgorithm: jsonMap['signatureAlgorithm'],
      rawValue: source,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'consumePurchaseData': consumePurchaseData?.toJson(),
      'dataSignature': dataSignature,
      'errMsg': errMsg,
      'returnCode': returnCode,
      'status': status?.toMap(),
      'signatureAlgorithm': signatureAlgorithm,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;

    return other is ConsumeOwnedPurchaseResult &&
        consumePurchaseData == other.consumePurchaseData &&
        dataSignature == other.dataSignature &&
        errMsg == other.errMsg &&
        returnCode == other.returnCode &&
        status == other.status &&
        signatureAlgorithm == other.signatureAlgorithm;
  }

  @override
  int get hashCode => Object.hash(
        consumePurchaseData,
        dataSignature,
        errMsg,
        returnCode,
        status,
        signatureAlgorithm,
      );
}
