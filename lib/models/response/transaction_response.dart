import 'dart:convert';

class TransactionResponse {
  TransactionResponse({
    this.paymentStatus,
    this.paymentCode,
  });

  String? paymentStatus;
  String? paymentCode;

  factory TransactionResponse.fromJson(String str) => TransactionResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransactionResponse.fromMap(Map<String, dynamic> json) => TransactionResponse(
        paymentCode: json["payment_code"] == null ? null : json["payment_code"],
        paymentStatus: json["payment_status"] == null ? null : json["payment_status"],
      );

  Map<String, dynamic> toMap() => {
        "payment_code": paymentCode == null ? null : paymentCode,
        "payment_status": paymentStatus == null ? null : paymentStatus,
      };
}
