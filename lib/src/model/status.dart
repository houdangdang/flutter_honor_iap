

part of '../../flutter_honor_iap.dart';

/// Task processing result.
class Status {
  /// Status code.
  ///
  /// - `0`: Success
  /// - `1`: Failure
  /// - `404`: No resource found
  /// - `500`: Internal error
  int? statusCode;

  /// Status description.
  String? statusMessage;

  /// Task processing result.
  Status? status;

  /// Creates a [Status] object.
  Status({
    this.statusCode,
    this.statusMessage,
    this.status,
  });

  /// Creates a [Status] object from a JSON string.
  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
    statusCode: json['statusCode'],
    statusMessage:
    json['statusMessage'] == null ? null : json['statusMessage'],
    status:
    json['status'] == null ? null : new Status.fromMap(json['status']),
  );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['statusMessage'] = this.statusMessage;
    if (this.status != null) {
      data['status'] = this.status!.toMap();
    }
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (this.runtimeType != other.runtimeType) return false;

    return other is Status &&
        this.statusCode == other.statusCode &&
        this.statusMessage == other.statusMessage &&
        this.status == other.status;
  }

  @override
  int get hashCode => Object.hash(
    statusCode,
    statusMessage,
    status,
  );
}