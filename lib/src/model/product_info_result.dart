part of flutter_honor_iap;

/// Information returned when the obtainProductInfo API is successfully called.
class ProductInfoResult {
  /// Result code description
  String? errMsg;

  /// List of found products.
  List<ProductInfo>? productInfoList;

  /// Result code.
  ///
  /// - `0`: The query is successful.
  String? returnCode;

  /// [Status] object that contains the task processing result.
  Status? status;

  /// Creates a [ProductInfoResult] object.
  ProductInfoResult({
    this.errMsg,
    this.productInfoList,
    this.returnCode,
    this.status,
  });

  /// Creates a [ProductInfoResult] object from a JSON string.
  factory ProductInfoResult.fromJson(String str) =>
      ProductInfoResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductInfoResult.fromMap(Map<dynamic, dynamic> json) =>
      ProductInfoResult(
        errMsg: json['errMsg'],
        productInfoList: json['productInfoList'] == null
            ? null
            : List<ProductInfo>.from(
                json['productInfoList']
                    .map((dynamic x) => ProductInfo.fromMap(x)),
              ).toList(),
        returnCode: json['returnCode']?.toString(),
        status: json['status'] == null ? null : Status.fromMap(json['status']),
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errMsg': errMsg,
      'productInfoList': productInfoList == null
          ? null
          : List<dynamic>.from(
              productInfoList!.map((ProductInfo x) => x.toMap()),
            ),
      'returnCode': returnCode,
      'status': status?.toMap(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;

    return other is ProductInfoResult &&
        errMsg == other.errMsg &&
        listEquals(productInfoList, other.productInfoList) &&
        returnCode == other.returnCode &&
        status == other.status;
  }

  @override
  int get hashCode => Object.hash(
        errMsg,
        Object.hashAll(productInfoList ?? <Iterable<Object>>[]),
        returnCode,
        status,
      );
}
