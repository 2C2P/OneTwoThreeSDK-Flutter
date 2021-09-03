/*
 * Created by Nonthawatt Phongwittayapanu on 3/9/21 5:15 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

import 'dart:convert';

import '../agent.dart';
import '../merchant.dart';
import '../transaction.dart';

class GetDeeplinkStatusResponse {
  GetDeeplinkStatusResponse({
    this.responseMessage,
    this.responseCode,
    this.checksum,
    this.agent,
    this.merchant,
    this.transaction,
  });

  String? responseMessage;
  String? responseCode;
  String? checksum;
  Agent? agent;
  Merchant? merchant;
  Transaction? transaction;

  factory GetDeeplinkStatusResponse.fromJson(String str) => GetDeeplinkStatusResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetDeeplinkStatusResponse.fromMap(Map<String, dynamic> json) => GetDeeplinkStatusResponse(
        responseMessage: json["response_message"] == null ? null : json["response_message"],
        responseCode: json["response_code"] == null ? null : json["response_code"],
        checksum: json["checksum"] == null ? null : json["checksum"],
        agent: json["agent"] == null ? null : Agent.fromMap(json["agent"]),
        merchant: json["merchant"] == null ? null : Merchant.fromMap(json["merchant"]),
        transaction: json["transaction"] == null ? null : Transaction.fromMap(json["transaction"]),
      );

  Map<String, dynamic> toMap() => {
        "response_message": responseMessage == null ? null : responseMessage,
        "response_code": responseCode == null ? null : responseCode,
        "checksum": checksum == null ? null : checksum,
        "agent": agent == null ? null : agent?.toMap(),
        "merchant": merchant == null ? null : merchant?.toMap(),
        "transaction": transaction == null ? null : transaction?.toMap(),
      };
}
