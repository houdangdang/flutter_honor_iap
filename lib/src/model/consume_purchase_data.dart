part of flutter_honor_iap;

class ConsumePurchaseData {
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

  ConsumePurchaseData({
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

  factory ConsumePurchaseData.fromJson(String str) =>
      ConsumePurchaseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConsumePurchaseData.fromMap(Map<String, dynamic> json) => ConsumePurchaseData(
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

