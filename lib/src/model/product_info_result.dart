part of flutter_honor_iap;

/// Information returned when the obtainProductInfo API is successfully called.
class ProductInfoResult {
  /// Result code description
  String? errMsg;

  /// List of found products.
  List<ProductInfo>? productInfos;

  /// Result code.
  ///
  /// - `0`: The query is successful.
  String? returnCode;

  /// [Status] object that contains the task processing result.
  Status? status;

  /// Creates a [ProductInfoResult] object.
  ProductInfoResult({
    this.errMsg,
    this.productInfos,
    this.returnCode,
    this.status,
  });

  /// Creates a [ProductInfoResult] object from a JSON string.
  factory ProductInfoResult.fromJson(String str) => ProductInfoResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductInfoResult.fromMap(Map<dynamic, dynamic> json) => ProductInfoResult(
    errMsg: json['errMsg'],
    productInfos: json['productInfos'] == null
        ? null
        : List<ProductInfo>.from(
      json['productInfos'].map((dynamic x) => ProductInfo.fromJson(x)),
    ).toList(),
    returnCode: json['returnCode']?.toString(),
    status: json['status'] == null ? null : Status.fromMap(json['status']),
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errMsg': errMsg,
      'productInfos': productInfos == null
          ? null
          : List<dynamic>.from(
        productInfos!.map((ProductInfo x) => x.toJson()),
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
        listEquals(productInfos, other.productInfos) &&
        returnCode == other.returnCode &&
        status == other.status;
  }

  @override
  int get hashCode => Object.hash(
    errMsg,
    Object.hashAll(productInfos ?? <Iterable<Object>>[]),
    returnCode,
    status,
  );
}
