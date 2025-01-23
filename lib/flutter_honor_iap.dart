library flutter_honor_iap;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

part 'src/honor_iap_client.dart';

part 'src/model/status.dart';

part 'src/model/base_req.dart';

part 'src/model/product_info.dart';

part 'src/model/product_info_req.dart';

part 'src/model/product_info_result.dart';

part 'src/model/in_app_purchase_data.dart';

part 'src/model/purchase_result_info.dart';

part 'src/model/purchase_intent_req.dart';

part 'src/model/consume_purchase_data.dart';

part 'src/model/consume_owned_purchase_req.dart';

part 'src/model/owned_purchases_result.dart';

class FlutterHonorIap {
  /// 初始化联运SDK
  static Future<bool> init({required String appId}) {
    return FlutterIapClient.init(appId: appId);
  }

  /// 初始化IAP SDK
  static Future<bool> getIapClient({
    required String appId,
    required String cpId,
    required String publicKey,
  }) async {
    if (Platform.isIOS) {
      return Future.value(false);
    }
    return FlutterIapClient.getIapClient(
      appId: appId,
      cpId: cpId,
      publicKey: publicKey,
    );
  }

  /// 检测环境是否已就绪
  static Future<bool> checkEnvReady() {
    return FlutterIapClient.checkEnvReady();
  }

  /// 获取在Honor配置的商品详情。请开发者避免从自有服务端获取商品信息，否则可能导致应用内商品价格和荣耀支付收银台价格不一致。
  /// @param {Number} priceType 商品类型。0：消耗型商品 1：非消耗型商品 2：订阅类商品
  /// @param {Array} productIds 商品的id数组
  /// @returns List<Object>
  static Future<ProductInfoResult> getProductInfo({
    required int priceType,
    required List<String> productIds,
  }) async {
    ProductInfoReq request =
        ProductInfoReq(priceType: priceType, productIds: productIds);
    ProductInfoResult result = await FlutterIapClient.getProductInfo(request);
    return result;
  }

  /// 创建购买Honor上配置商品的订单。
  /// 在Honor创建商品后，使用此接口调用荣耀收银台，显示商品、价格和支付方式。
  /// 荣耀会根据国际汇率变动进行商品价格档调整，为了保证应用内商品价格显示一致，
  /// 请同时使用consumeProduct接口获取商品详情，避免从自有服务端获取价格，以免在汇率变动价格调整时，导致价格显示不一致。
  /// @param {Number} priceType 商品类型。0：消耗型商品 1：非消耗型商品 2：订阅类商品
  /// @param {String} productId 产品id
  /// @param {String} developerPayload 商户侧保留信息。若该字段有值，在支付成功后的回调结果中会原样返回给应用(这个地方)
  /// @param {bool} autoConsume 是否自动消耗商品,如果设置为false，需手动调用consumeProduct方法进行消耗,或者由服务端进行消耗
  /// @param {bool} sandboxTest 是否设置沙盒环境，设置为1则为沙盒环境(如果要沙盒测试，仅设置此参数无用，还需在荣耀后台添加沙盒测试账号)
  /// @returns Object
  static Future<PurchaseResultInfo> createProductOrderIntent({
    required int priceType,
    required String productId,
    String? developerPayload = "",
    bool? autoConsume = true,
    int? sandboxTest = 0,
  }) async {
    PurchaseIntentReq request = PurchaseIntentReq(
      priceType: priceType,
      productId: productId,
      developerPayload: developerPayload,
      autoConsume: autoConsume,
      sandboxTest: sandboxTest,
    );
    PurchaseResultInfo result =
        await FlutterIapClient.createProductOrderIntent(request);
    return result;
  }

  /// 针对消耗型商品，在商品支付成功后，应用需要在发放商品之后调用此接口对消耗商品执行消耗操作。
  /// 如果在消耗之后进行发货，可能存在以下异常场景：调用消耗接口过程中，服务器消耗成功但因网络异常等原因没有成功将结果回调给端侧，从而造成服务器已经消耗但是端侧没有发货的场景。此场景后续很难处理，所以建议开发者在发货之后再执行消耗操作。
  /// 开发者需要把已发货的token传至应用的服务器，后续即使消耗失败也可以从服务器获取数据进行对比，避免出现异常。建议开发者在发货前检查应用服务器，以确保每个购买令牌都未使用过，即未发过货。
  /// @param {String} purchaseToken 用户购买商品的标识，在支付商品时由支付服务器生成并在InAppPurchaseData中返回给应用。应用传入此参数供支付服务器对订单状态进行更新后再发放商品
  /// @returns Object
  static Future<PurchaseResultInfo> consumeProduct({
    required String purchaseToken,
  }) async {
    ConsumeOwnedPurchaseReq request = ConsumeOwnedPurchaseReq(
      purchaseToken: purchaseToken,
    );
    PurchaseResultInfo result = await FlutterIapClient.consumeProduct(request);
    return result;
  }

  /// 取消订阅
  /// @param {String} agreementNo 合约号，从获取的已购订阅商品信息中获取
  /// @param {String} iapOrderNo 支付成功时生成的订单号
  static Future<bool> cancelSubscriptionProduct({
    required String agreementNo,
    required String iapOrderNo,
  }) async {
    bool result = await FlutterIapClient.cancelSubscriptionProduct(
      agreementNo: agreementNo,
      iapOrderNo: iapOrderNo,
    );
    return result;
  }

  /// 查询已购买未消耗的列表(消耗型商品补单需要)、用户已订购商品的购买数据
  /// @param {Number} productType 商品类型。0：消耗型商品 1：非消耗型商品 2：订阅类商品
  /// @param {String} continueToken 用于获取下一个列表的数据，第一次为空，如果有更多数据ContinueToken有值，为空则没有更多数据
  /// @returns Object
  static Future<OwnedPurchasesResult> getOwnedPurchased({
    required int productType,
    String? continueToken,
  }) async {
    return FlutterIapClient.getOwnedPurchased(
      productType: productType,
      continueToken: continueToken,
    );
  }

  /// 查看用户历史购买记录
  /// @param {Number} productType 商品类型。0：消耗型商品 1：非消耗型商品 2：订阅类商品
  /// @param {String} continueToken 用于获取下一个列表的数据，第一次为空，如果有更多数据ContinueToken有值，为空则没有更多数据
  /// @returns Object
  static Future<OwnedPurchasesResult> getOwnedPurchaseRecord({
    required int productType,
    String? continueToken,
  }) {
    return FlutterIapClient.getOwnedPurchaseRecord(
      productType: productType,
      continueToken: continueToken,
    );
  }

  /// 关闭日志
  static Future<void> disableLogger()  {
    return FlutterIapClient.disableLogger();
  }

  /// 打开日志
  static Future<void> enableLogger() async {
    return FlutterIapClient.enableLogger();
  }
}
