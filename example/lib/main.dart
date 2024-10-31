import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:flutter_honor_iap_example/honor_iap_util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isInstalled = false;
  String _logMsg = '';

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void _initHonorIap() async {
    if (!_isInstalled) {
      _isInstalled = await HonorIapUtil.initHonorIap();
      _logMsg = _isInstalled ? '初始化成功' : '初始化失败';
      setState(() {});
    }
  }

  void _getProductInfo(int priceType, String productId) async {
    try {
      if (!_isInstalled) {
        setState(() => _logMsg = '未初始化，请先初始化');
        return;
      }
      final result = await HonorIapUtil.getProductInfo(
        priceType: priceType,
        productIds: [productId],
      );
      setState(() => _logMsg = result.toJson());
    } on PlatformException catch (e) {
      setState(() => _logMsg = e?.message ?? '获取产品信息失败');
    }
  }

  void _createProductOrderIntent({
    required int priceType,
    required String productId,
    String? developerPayload = "",
    bool? autoConsume = true,
    int? sandboxTest = 0,
  }) async {
    try {
      if (!_isInstalled) {
        setState(() => _logMsg = '未初始化，请先初始化');
        return;
      }
      final result = await HonorIapUtil.createProductOrderIntent(
        priceType: priceType,
        productId: productId,
        developerPayload: developerPayload,
        autoConsume: autoConsume,
        sandboxTest: sandboxTest,
      );
      setState(() => _logMsg = result.toJson());
    } on PlatformException catch (e) {
      setState(() => _logMsg = e?.message ?? '支付失败');
    }
  }
  
  void _getOwnedPurchased(int productType) async {
    try {
      if (!_isInstalled) {
        setState(() => _logMsg = '未初始化，请先初始化');
        return;
      }
      final result = await HonorIapUtil.getOwnedPurchased(productType: productType);
      setState(() => _logMsg = result.toJson());
    } on PlatformException catch (e) {
      setState(() => _logMsg = e?.message ?? '支付失败');
    }
  }

  void _getOwnedPurchaseRecord(int productType) async {
    try {
      if (!_isInstalled) {
        setState(() => _logMsg = '未初始化，请先初始化');
        return;
      }
      final result = await HonorIapUtil.getOwnedPurchaseRecord(productType: productType);
      setState(() => _logMsg = result.toJson());
    } on PlatformException catch (e) {
      setState(() => _logMsg = e?.message ?? '支付失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    final normalTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.blue[900],
    );
    final disableTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.grey[500],
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Honor IAP Plugin Demo'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: _logMsg.isNotEmpty,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    color: Colors.grey[100],
                    child: Text(
                      _logMsg,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !_isInstalled,
                  child: TextButton(
                    onPressed: _initHonorIap,
                    child: Text(
                      '初始化',
                      style: _isInstalled ? disableTextStyle : normalTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => _getProductInfo(0, 'test1'),
                  child: Text(
                    '获取【消耗型】商品信息【test1】',
                    style: _isInstalled ? normalTextStyle : disableTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => _getProductInfo(2, 'autotest1'),
                  child: Text(
                    '获取【自动续费订阅】商品信息【autotest1】',
                    style: _isInstalled ? normalTextStyle : disableTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => _getProductInfo(2, 'autotest2'),
                  child: Text(
                    '获取【自动续费订阅】商品信息【autotest2】含促销价',
                    style: _isInstalled ? normalTextStyle : disableTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => _createProductOrderIntent(priceType: 0, productId: 'test1'),
                  child: Text(
                    '支付【消耗型】商品信息【test1】自动消耗',
                    style: _isInstalled ? normalTextStyle : disableTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => _createProductOrderIntent(priceType: 0, productId: 'test1', autoConsume: false),
                  child: Text(
                    '支付【消耗型】商品信息【test1】',
                    style: _isInstalled ? normalTextStyle : disableTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => _createProductOrderIntent(priceType: 2, productId: 'autotest1'),
                  child: Text(
                    '支付【自动续费订阅】商品信息【autotest1】',
                    style: _isInstalled ? normalTextStyle : disableTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => _createProductOrderIntent(priceType: 2, productId: 'autotest2'),
                  child: Text(
                    '支付【自动续费订阅】商品信息【autotest2】含促销价',
                    style: _isInstalled ? normalTextStyle : disableTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => _getOwnedPurchased(0),
                  child: Text(
                    '查询已购买未消耗的列表(消耗型商品补单需要)、用户已订购商品的购买数据',
                    style: _isInstalled ? normalTextStyle : disableTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => _getOwnedPurchaseRecord(0),
                  child: Text(
                    '查看用户历史购买记录',
                    style: _isInstalled ? normalTextStyle : disableTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
