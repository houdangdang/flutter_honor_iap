part of flutter_honor_iap;

/// Information returned when the obtainOwnedPurchases or obtainOwnedPurchaseRecord API is successfully called.
class OwnedPurchasesResult {
  /// Data location flag.
  ///
  /// If a user has a large number of products and the response contains continueToken, the app must initiate another call on the current method and pass continueToken currently received.
  ///
  /// If product query is still incomplete, the app needs to call the API again until no continueToken is returned, indicating that all products are returned.
  String? continueToken;

  /// Information about products that have been purchased but not consumed or about all existing subscription relationships of users, which is returned using the `obtainOwnedPurchases` method.
  ///
  /// Historical consumable information or all subscription receipts, which are returned using the `getOwnedPurchaseRecord` method.
  List<InAppPurchaseData>? purchaseList;

  List<String>? sigList;

  String? sigAlgorithm;

  /// Creates an [OwnedPurchasesResult] object.
  OwnedPurchasesResult({
    this.continueToken,
    this.purchaseList,
    this.sigList,
    this.sigAlgorithm,
  });

  /// Creates an [OwnedPurchasesResult] object from a JSON string.
  factory OwnedPurchasesResult.fromJson(String str) =>
      OwnedPurchasesResult.fromMap(str);

  String toJson() => json.encode(toMap());

  factory OwnedPurchasesResult.fromMap(String source) {
    Map<String, dynamic> jsonMap = json.decode(source);

    return OwnedPurchasesResult(
      continueToken: jsonMap['continueToken'],
      purchaseList: jsonMap['purchaseList'] == null
          ? null
          : List<InAppPurchaseData>.from(
              jsonMap['purchaseList']
                  .map((dynamic x) => InAppPurchaseData.fromJson(x)),
            ).toList(),
      sigList: jsonMap['sigList'] == null
          ? null
          : (jsonMap['sigList'] as List<dynamic>)
              .map((dynamic e) => e.toString())
              .toList(),
      sigAlgorithm: jsonMap['sigAlgorithm'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'continueToken': continueToken,
      'purchaseList': purchaseList == null
          ? null
          : List<dynamic>.from(
              purchaseList!.map((InAppPurchaseData x) => x),
            ),
      'sigList': sigList == null
          ? null
          : List<dynamic>.from(sigList!.map((String x) => x)),
      'sigAlgorithm': sigAlgorithm,
    };
  }
}
