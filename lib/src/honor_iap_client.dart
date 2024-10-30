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
  static Future<bool> getIapClient({
    required String appId,
    required String cpId,
    required String publicKey,
  }) async {
    bool result = await _channel.invokeMethod(
      'getIapClient',
      <String, String>{'appId': appId, 'cpId': cpId, 'publicKey': publicKey},
    );
    return result;
  }

  /// 检测环境是否已就绪
  static Future<bool> checkEnvReady() async {
    bool result = await _channel.invokeMethod('checkEnvReady');
    return result;
  }

  /// Get product details configured in Honor.
  static Future<ProductInfoResult> getProductInfo(ProductInfoReq request) async {
    final products = await _channel.invokeMethod('getProductInfo', request.toMap());
    return ProductInfoResult.fromJson(products);
  }

  /// Creates orders for products managed by the product management system (PMS), including consumables, non-consumables, and subscriptions.
  static Future<PurchaseResultInfo> createProductOrderIntent(
      PurchaseIntentReq request,
      ) async {
    return PurchaseResultInfo.fromJson(
      await _channel.invokeMethod('createProductOrderIntent', request.toMap()),
    );
  }

  /// Consumes a consumable after it is successfully delivered.
  static Future<ConsumeOwnedPurchaseResult> consumeProduct(
      ConsumeOwnedPurchaseReq request,
      ) async {
    return ConsumeOwnedPurchaseResult.fromJson(
      await _channel.invokeMethod('consumeProduct', request.toMap()),
    );
  }

  /// 取消订阅
  static Future<bool> cancelSubscriptionProduct({
    required String agreementNo,
    required String iapOrderNo,
  }) async {
    bool result = await _channel.invokeMethod(
      'cancelSubscriptionProduct',
      <String, String>{'agreementNo': agreementNo, 'iapOrderNo': iapOrderNo},
    );
    return result;
  }

  /// 关闭日志
  static Future<void> disableLogger() async {
    return await _channel.invokeMethod('disableLogger');
  }

  /// 打开日志
  static Future<void> enableLogger() async {
    return await _channel.invokeMethod('enableLogger');
  }

}
