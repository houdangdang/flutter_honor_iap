part of '../../flutter_honor_iap.dart';

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

  int? applicationId;
  bool? autoRenewing;
  String? orderId;
  String? packageName;
  String? productId;
  String? productName;
  int? purchaseTime;
  int? purchaseState;
  String? developerPayload;
  String? purchaseToken;
  int? purchaseType;
  String? currency;
  int? price;
  String? country;
  String? lastOrderId;
  String? productGroup;
  int? oriPurchaseTime;
  String? subscriptionId;
  int? quantity;
  int? daysLasted;
  int? numOfPeriods;
  int? numOfDiscounts;
  int? expirationDate;
  int? expirationIntent;
  int? retryFlag;
  int? introductoryFlag;
  int? trialFlag;
  int? cancelTime;
  int? cancelReason;
  String? appInfo;
  int? notifyClosed;
  int? renewStatus;
  int? priceConsentStatus;
  int? renewPrice;
  bool? subIsvalid;
  int? cancelledSubKeepDays;
  int? kind;
  String? developerChallenge;
  int? consumptionState;
  String? payOrderId;
  String? payType;
  int? deferFlag;
  String? oriSubscriptionId;
  int? cancelWay;
  int? cancellationTime;
  int? resumeTime;
  int? accountFlag;
  int? purchaseTimeMillis;
  int? confirmed;
  int? graceExpirationTime;

  InAppPurchaseData({
    this.autoRenewing,
    this.orderId,
    this.packageName,
    this.applicationId,
    this.kind,
    this.productId,
    this.productName,
    this.purchaseTime,
    this.purchaseTimeMillis,
    this.purchaseState,
    this.developerPayload,
    this.purchaseToken,
    this.consumptionState,
    this.confirmed,
    this.currency,
    this.price,
    this.country,
    this.payOrderId,
    this.payType,
    this.purchaseType,
    this.lastOrderId,
    this.productGroup,
    this.oriPurchaseTime,
    this.subscriptionId,
    this.quantity,
    this.daysLasted,
    this.numOfPeriods,
    this.numOfDiscounts,
    this.expirationDate,
    this.expirationIntent,
    this.retryFlag,
    this.introductoryFlag,
    this.trialFlag,
    this.cancelTime,
    this.cancelReason,
    this.appInfo,
    this.notifyClosed,
    this.renewStatus,
    this.subIsvalid,
    this.cancelledSubKeepDays,
    this.developerChallenge,
    this.deferFlag,
    this.oriSubscriptionId,
    this.cancelWay,
    this.cancellationTime,
    this.resumeTime,
    this.accountFlag,
    this.priceConsentStatus,
    this.renewPrice,
    this.graceExpirationTime,
  });

  factory InAppPurchaseData.fromJson(String str) =>
      InAppPurchaseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InAppPurchaseData.fromMap(Map<dynamic, dynamic> json) =>
      InAppPurchaseData(
        autoRenewing: json['autoRenewing'],
        orderId: json['orderId'],
        packageName: json['packageName'],
        applicationId: json['applicationId'],
        kind: json['kind'],
        productId: json['productId'],
        productName: json['productName'],
        purchaseTime: json['purchaseTime'],
        purchaseTimeMillis: json['purchaseTimeMillis'],
        purchaseState: json['purchaseState'],
        developerPayload: json['developerPayload'],
        purchaseToken: json['purchaseToken'],
        currency: json['currency'],
        price: json['price'],
        country: json['country'],
        payOrderId: json['payOrderId'],
        payType: json['payType'],
        purchaseType: json['purchaseType'],
        lastOrderId: json['lastOrderId'],
        productGroup: json['productGroup'],
        oriPurchaseTime: json['oriPurchaseTime'],
        subscriptionId: json['subscriptionId'],
        quantity: json['quantity'],
        daysLasted: json['daysLasted'],
        numOfPeriods: json['numOfPeriods'],
        numOfDiscounts: json['numOfDiscounts'],
        expirationDate: json['expirationDate'],
        expirationIntent: json['expirationIntent'],
        retryFlag: json['retryFlag'],
        introductoryFlag: json['introductoryFlag'],
        trialFlag: json['trialFlag'],
        cancelTime: json['cancelTime'],
        cancelReason: json['cancelReason'],
        appInfo: json['appInfo'],
        notifyClosed: json['notifyClosed'],
        renewStatus: json['renewStatus'],
        subIsvalid: json['subIsvalid'],
        cancelledSubKeepDays: json['cancelledSubKeepDays'],
        developerChallenge: json['developerChallenge'],
        deferFlag: json['deferFlag'],
        oriSubscriptionId: json['oriSubscriptionId'],
        cancelWay: json['cancelWay'],
        cancellationTime: json['cancellationTime'],
        resumeTime: json['resumeTime'],
        accountFlag: json['accountFlag'],
        renewPrice: json['renewPrice'],
        priceConsentStatus: json['priceConsentStatus'],
        graceExpirationTime: json['graceExpirationTime'],
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'autoRenewing': autoRenewing,
      'orderId': orderId,
      'packageName': packageName,
      'applicationId': applicationId,
      'kind': kind,
      'productId': productId,
      'productName': productName,
      'purchaseTime': purchaseTime,
      'purchaseTimeMillis': purchaseTimeMillis,
      'purchaseState': purchaseState,
      'developerPayload': developerPayload,
      'purchaseToken': purchaseToken,
      'consumptionState': consumptionState,
      'confirmed': confirmed,
      'currency': currency,
      'price': price,
      'country': country,
      'payOrderId': payOrderId,
      'payType': payType,
      'purchaseType': purchaseType,
      'lastOrderId': lastOrderId,
      'productGroup': productGroup,
      'oriPurchaseTime': oriPurchaseTime,
      'subscriptionId': subscriptionId,
      'quantity': quantity,
      'daysLasted': daysLasted,
      'numOfPeriods': numOfPeriods,
      'numOfDiscounts': numOfDiscounts,
      'expirationDate': expirationDate,
      'expirationIntent': expirationIntent,
      'retryFlag': retryFlag,
      'introductoryFlag': introductoryFlag,
      'trialFlag': trialFlag,
      'cancelTime': cancelTime,
      'cancelReason': cancelReason,
      'appInfo': appInfo,
      'notifyClosed': notifyClosed,
      'renewStatus': renewStatus,
      'subIsvalid': subIsvalid,
      'cancelledSubKeepDays': cancelledSubKeepDays,
      'developerChallenge': developerChallenge,
      'deferFlag': deferFlag,
      'oriSubscriptionId': oriSubscriptionId,
      'cancelWay': cancelWay,
      'cancellationTime': cancellationTime,
      'resumeTime': resumeTime,
      'accountFlag': accountFlag,
      'renewPrice': renewPrice,
      'priceConsentStatus': priceConsentStatus,
      'graceExpirationTime': graceExpirationTime,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;

    return other is InAppPurchaseData &&
        autoRenewing == other.autoRenewing &&
        orderId == other.orderId &&
        packageName == other.packageName &&
        applicationId == other.applicationId &&
        kind == other.kind &&
        productId == other.productId &&
        productName == other.productName &&
        purchaseTime == other.purchaseTime &&
        purchaseTimeMillis == other.purchaseTimeMillis &&
        purchaseState == other.purchaseState &&
        developerPayload == other.developerPayload &&
        purchaseToken == other.purchaseToken &&
        currency == other.currency &&
        price == other.price &&
        country == other.country &&
        payOrderId == other.payOrderId &&
        payType == other.payType &&
        purchaseType == other.purchaseType &&
        lastOrderId == other.lastOrderId &&
        productGroup == other.productGroup &&
        oriPurchaseTime == other.oriPurchaseTime &&
        subscriptionId == other.subscriptionId &&
        quantity == other.quantity &&
        daysLasted == other.daysLasted &&
        numOfPeriods == other.numOfPeriods &&
        numOfDiscounts == other.numOfDiscounts &&
        expirationDate == other.expirationDate &&
        expirationIntent == other.expirationIntent &&
        retryFlag == other.retryFlag &&
        introductoryFlag == other.introductoryFlag &&
        trialFlag == other.trialFlag &&
        cancelTime == other.cancelTime &&
        cancelReason == other.cancelReason &&
        appInfo == other.appInfo &&
        notifyClosed == other.notifyClosed &&
        renewStatus == other.renewStatus &&
        subIsvalid == other.subIsvalid &&
        cancelledSubKeepDays == other.cancelledSubKeepDays &&
        developerChallenge == other.developerChallenge &&
        deferFlag == other.deferFlag &&
        oriSubscriptionId == other.oriSubscriptionId &&
        cancelWay == other.cancelWay &&
        cancellationTime == other.cancellationTime &&
        resumeTime == other.resumeTime &&
        accountFlag == other.accountFlag &&
        renewPrice == other.renewPrice &&
        priceConsentStatus == other.priceConsentStatus &&
        graceExpirationTime == other.graceExpirationTime;
  }

  @override
  int get hashCode => Object.hashAll(
        <dynamic>[
          autoRenewing,
          orderId,
          packageName,
          applicationId,
          kind,
          productId,
          productName,
          purchaseTime,
          purchaseTimeMillis,
          purchaseState,
          developerPayload,
          purchaseToken,
          consumptionState,
          confirmed,
          currency,
          price,
          country,
          payOrderId,
          payType,
          purchaseType,
          lastOrderId,
          productGroup,
          oriPurchaseTime,
          subscriptionId,
          quantity,
          daysLasted,
          numOfPeriods,
          numOfDiscounts,
          expirationDate,
          expirationIntent,
          retryFlag,
          introductoryFlag,
          trialFlag,
          cancelTime,
          cancelReason,
          appInfo,
          notifyClosed,
          renewStatus,
          subIsvalid,
          cancelledSubKeepDays,
          developerChallenge,
          deferFlag,
          oriSubscriptionId,
          cancelWay,
          cancellationTime,
          resumeTime,
          accountFlag,
          renewPrice,
          priceConsentStatus,
          graceExpirationTime,
        ],
      );
}
