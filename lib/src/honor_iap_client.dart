// ignore_for_file: constant_identifier_names

part of '../flutter_honor_iap.dart';

/// Provides all APIs of Flutter IAP Plugin.
class FlutterIapClient {
  static const MethodChannel _channel = MethodChannel('FlutterIapClient');

  /// Consumable.
  ///
  /// Original value: `0`.
  static const int CONSUMABLE = 0;

  /// Non-consumable.
  ///
  /// Original value: `1`.
  static const int PERMANENT = 1;

  /// Subscription.
  ///
  /// Original value: `2`.
  static const int SUBSCRIPTION = 2;

  /// 初始化IAP SDK
  static Future<bool> getIapClient(String appId, String cpId) async {
    bool result = await _channel.invokeMethod(
      'getIapClient',
      <String, String>{'appId': appId, 'cpId': cpId },
    );
    return result;
  }

  /// 检测环境是否已就绪
  static Future<bool> checkEnvReady() async {
    bool result = await _channel.invokeMethod('checkEnvReady');
    return result;
  }

  /// Get product details configured in Honor.
  static Future<ProductInfoResult> getProductInfo(
    ProductInfoReq request,
  ) async {
    return ProductInfoResult.fromJson(
      await _channel.invokeMethod('getProductInfo', request.toMap()),
    );
  }

  // /// Displays the subscription editing screen or subscription management screen of HUAWEI IAP.
  // static Future<void> startIapActivity(StartIapActivityReq request) async {
  //   return await _channel.invokeMethod('startIapActivity', request.toMap());
  // }

  // /// Creates orders for products managed by the product management system (PMS), including consumables, non-consumables, and subscriptions.
  // static Future<PurchaseResultInfo> createPurchaseIntent(
  //   PurchaseIntentReq request,
  // ) async {
  //   return PurchaseResultInfo.fromJson(
  //     await _channel.invokeMethod('createPurchaseIntent', request.toMap()),
  //   );
  // }

  // /// Queries order information of purchased products.
  // static Future<OwnedPurchasesResult> obtainOwnedPurchases(
  //   OwnedPurchasesReq request,
  // ) async {
  //   return OwnedPurchasesResult.fromJson(
  //     await _channel.invokeMethod('obtainOwnedPurchases', request.toMap()),
  //   );
  // }

  // /// Consumes a consumable after it is successfully delivered.
  // static Future<ConsumeOwnedPurchaseResult> consumeOwnedPurchase(
  //   ConsumeOwnedPurchaseReq request,
  // ) async {
  //   return ConsumeOwnedPurchaseResult.fromJson(
  //     await _channel.invokeMethod('consumeOwnedPurchase', request.toMap()),
  //   );
  // }

  // /// Obtains the purchase information of all consumed products or the receipts of all subscriptions.
  // static Future<OwnedPurchasesResult> obtainOwnedPurchaseRecord(
  //   OwnedPurchasesReq request,
  // ) async {
  //   return OwnedPurchasesResult.fromJson(
  //     await _channel.invokeMethod(
  //       'obtainOwnedPurchaseRecord',
  //       request.toMap(),
  //     ),
  //   );
  // }

  // /// Disables HMS Plugin Method Analytics which is used for sending usage analytics of HUAWEI IAP SDK's methods to improve the service quality.
  // static Future<void> disableLogger() async {
  //   await _channel.invokeMethod('disableLogger');
  // }

  // /// Enables HMS Plugin Method Analytics which is used for sending usage analytics of HUAWEI IAP SDK's methods to improve the service quality.
  // static Future<void> enableLogger() async {
  //   await _channel.invokeMethod('enableLogger');
  // }

  // /// Enables pending purchase.
  // static Future<String> enablePendingPurchase() async {
  //   String? result = await _channel.invokeMethod('enablePendingPurchase');
  //   return result!;
  // }
}
