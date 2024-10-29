part of '../../flutter_honor_iap.dart';

/// Store user's purchase information about consumables, non-consumables, and subscriptions.
class ConsumePurchaseData {
  final int? applicationId;
  final bool? autoRenewing;
  final String? orderId;
  final String? packageName;
  final String? productId;
  final int? purchaseTime;
  final int? purchaseState;
  final String? developerPayload;
  final String? purchaseToken;
  final String? developerChallenge;
  final int? consumptionState;
  final int? acknowledged;
  final String? currency;
  final int? price;
  final String? country;
  final String? responseCode;
  final String? responseMessage;
  final int? kind;
  final String? productName;
  final int? purchaseTimeMillis;
  final int? confirmed;
  final int? purchaseType;
  final String? payOrderId;
  final String? payType;

  ConsumePurchaseData({
    this.autoRenewing,
    this.orderId,
    this.packageName,
    this.applicationId,
    this.productId,
    this.purchaseTime,
    this.purchaseState,
    this.developerPayload,
    this.purchaseToken,
    this.consumptionState,
    this.currency,
    this.price,
    this.country,
    this.developerChallenge,
    this.acknowledged,
    this.responseCode,
    this.responseMessage,
    this.kind,
    this.productName,
    this.purchaseTimeMillis,
    this.confirmed,
    this.purchaseType,
    this.payOrderId,
    this.payType,
  });

  factory ConsumePurchaseData.fromJson(String str) =>
      ConsumePurchaseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConsumePurchaseData.fromMap(Map<String, dynamic> json) {
    return ConsumePurchaseData(
      applicationId: json['applicationId'],
      autoRenewing: json['autoRenewing'],
      orderId: json['orderId'],
      packageName: json['packageName'],
      productId: json['productId'],
      purchaseTime: json['purchaseTime'],
      purchaseState: json['purchaseState'],
      developerPayload: json['developerPayload'],
      purchaseToken: json['purchaseToken'],
      developerChallenge: json['developerChallenge'],
      consumptionState: json['consumptionState'],
      acknowledged: json['acknowledged'],
      currency: json['currency'],
      price: json['price'],
      country: json['country'],
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      kind: json['kind'],
      productName: json['productName'],
      purchaseTimeMillis: json['purchaseTimeMillis'],
      confirmed: json['confirmed'],
      purchaseType: json['purchaseType'],
      payOrderId: json['payOrderId'],
      payType: json['payType'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'autoRenewing': autoRenewing,
      'orderId': orderId,
      'packageName': packageName,
      'applicationId': applicationId,
      'productId': productId,
      'purchaseTime': purchaseTime,
      'purchaseState': purchaseState,
      'developerPayload': developerPayload,
      'purchaseToken': purchaseToken,
      'consumptionState': consumptionState,
      'currency': currency,
      'price': price,
      'country': country,
      'developerChallenge': developerChallenge,
      'acknowledged': acknowledged,
      'responseCode': responseCode,
      'responseMessage': responseMessage,
      'kind': kind,
      'productName': productName,
      'purchaseTimeMillis': purchaseTimeMillis,
      'confirmed': confirmed,
      'purchaseType': purchaseType,
      'payOrderId': payOrderId,
      'payType': payType,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;

    return other is ConsumePurchaseData &&
        autoRenewing == other.autoRenewing &&
        orderId == other.orderId &&
        packageName == other.packageName &&
        applicationId == other.applicationId &&
        productId == other.productId &&
        purchaseTime == other.purchaseTime &&
        purchaseState == other.purchaseState &&
        developerPayload == other.developerPayload &&
        purchaseToken == other.purchaseToken &&
        consumptionState == other.consumptionState &&
        currency == other.currency &&
        price == other.price &&
        country == other.country &&
        developerChallenge == other.developerChallenge &&
        acknowledged == other.acknowledged &&
        responseCode == other.responseCode &&
        responseMessage == other.responseMessage &&
        kind == other.kind &&
        productName == other.productName &&
        purchaseTimeMillis == other.purchaseTimeMillis &&
        confirmed == other.confirmed &&
        purchaseType == other.purchaseType &&
        payOrderId == other.payOrderId &&
        payType == other.payType;
  }

  @override
  int get hashCode => Object.hash(
        autoRenewing,
        orderId,
        packageName,
        applicationId,
        productId,
        purchaseTime,
        purchaseState,
        developerPayload,
        purchaseToken,
        consumptionState,
        currency,
        price,
        country,
        developerChallenge,
        acknowledged,
        responseCode,
        responseMessage,
        kind,
        productName,
        Object.hashAll(
          <Object?>[
            purchaseTimeMillis,
            confirmed,
            purchaseType,
            payOrderId,
            payType,
          ],
        ),
      );
}
