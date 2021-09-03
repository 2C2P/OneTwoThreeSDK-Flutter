/*
 * Created by Nonthawatt Phongwittayapanu on 3/9/21 5:05 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

import 'dart:convert';

import '../merchant.dart';
import '../transaction.dart';

class StartDeeplinkResponse {
  StartDeeplinkResponse({
    this.responseMessage,
    this.responseCode,
    this.deeplinkUrl,
    this.checksum,
    this.merchant,
    this.transaction,
  });

  String? responseMessage;
  String? responseCode;
  String? deeplinkUrl;
  String? checksum;
  Merchant? merchant;
  Transaction? transaction;

  factory StartDeeplinkResponse.fromJson(String str) => StartDeeplinkResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StartDeeplinkResponse.fromMap(Map<String, dynamic> json) => StartDeeplinkResponse(
        responseMessage: json["response_message"] == null ? null : json["response_message"],
        responseCode: json["response_code"] == null ? null : json["response_code"],
        deeplinkUrl: json["deeplink_url"] == null ? null : json["deeplink_url"],
        checksum: json["checksum"] == null ? null : json["checksum"],
        merchant: json["merchant"] == null ? null : Merchant.fromMap(json["merchant"]),
        transaction: json["transaction"] == null ? null : Transaction.fromMap(json["transaction"]),
      );

  Map<String, dynamic> toMap() => {
        "response_message": responseMessage == null ? null : responseMessage,
        "response_code": responseCode == null ? null : responseCode,
        "deeplink_url": deeplinkUrl == null ? null : deeplinkUrl,
        "checksum": checksum == null ? null : checksum,
        "merchant": merchant == null ? null : merchant?.toMap(),
        "transaction": transaction == null ? null : transaction?.toMap(),
      };
}
