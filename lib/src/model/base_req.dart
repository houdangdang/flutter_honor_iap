part of flutter_honor_iap;

/// Base class to request information.
abstract class BaseReq {
  /// Additional information passed via a JSON string in key-value format.
  String? reservedInfor;

  BaseReq({required this.reservedInfor});
}