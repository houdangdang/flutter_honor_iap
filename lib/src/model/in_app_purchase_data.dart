part of flutter_honor_iap;

/// Provides a tool that parses the InAppPurchaseData string.
class InAppPurchaseData {
  /// Indicates that the field does not exist in the source JSON string.
  static const int NOT_PRESENT = -2147483648;

  /// Purchase State
  static const int INITIALIZED = -2147483648;
  static const int PURCHASED = 0;
  static const int CANCELED = 1;
  static const int REFUNDED = 2;
  static const int PENDING = 3;

  final String? appId;
  final String? orderId;
  final String? bizOrderNo;
  final int? productType;
  final String? productId;
  final String? productName;
  final int? purchaseTime;
  final int? purchaseState;
  final int? consumptionState;
  final String? purchaseToken;
  final String? currency;
  final String? productPrice;
  final double? price;
  final String? payMoney;
  final String? developerPayload;
  final String? displayPrice;
  final String? oriOrder;
  final int? sandboxFlag;
  final String? channelCode;

  InAppPurchaseData({
    this.appId,
    this.orderId,
    this.bizOrderNo,
    this.productType,
    this.productId,
    this.productName,
    this.purchaseTime,
    this.purchaseState,
    this.consumptionState,
    this.purchaseToken,
    this.currency,
    this.productPrice,
    this.price,
    this.payMoney,
    this.developerPayload,
    this.displayPrice,
    this.oriOrder,
    this.sandboxFlag,
    this.channelCode,
  });

  factory InAppPurchaseData.fromJson(String str) =>
      InAppPurchaseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InAppPurchaseData.fromMap(Map<String, dynamic> json) => InAppPurchaseData(
    appId: json["appId"],
    orderId: json["orderId"],
    bizOrderNo: json["bizOrderNo"],
    productType: json["productType"],
    productId: json["productId"],
    productName: json["productName"],
    purchaseTime: json["purchaseTime"],
    purchaseState: json["purchaseState"],
    consumptionState: json["consumptionState"],
    purchaseToken: json["purchaseToken"],
    currency: json["currency"],
    productPrice: json["productPrice"],
    price: json["price"]?.toDouble(),
    payMoney: json["payMoney"],
    developerPayload: json["developerPayload"],
    displayPrice: json["displayPrice"],
    oriOrder: json["oriOrder"],
    sandboxFlag: json["sandboxFlag"],
    channelCode: json["channelCode"],
  );

  Map<String, dynamic> toMap() => {
    "appId": appId,
    "orderId": orderId,
    "bizOrderNo": bizOrderNo,
    "productType": productType,
    "productId": productId,
    "productName": productName,
    "purchaseTime": purchaseTime,
    "purchaseState": purchaseState,
    "consumptionState": consumptionState,
    "purchaseToken": purchaseToken,
    "currency": currency,
    "productPrice": productPrice,
    "price": price,
    "payMoney": payMoney,
    "developerPayload": developerPayload,
    "displayPrice": displayPrice,
    "oriOrder": oriOrder,
    "sandboxFlag": sandboxFlag,
    "channelCode": channelCode,
  };
}
