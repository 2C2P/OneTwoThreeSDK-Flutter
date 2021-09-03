/*
 * Created by Nonthawatt Phongwittayapanu on 3/9/21 5:25 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

import 'dart:convert';

class CancelDeeplinkResponse {
  CancelDeeplinkResponse({
    this.responseMessage,
    this.responseCode,
    this.checksum,
  });

  String? responseMessage;
  String? responseCode;
  String? checksum;

  factory CancelDeeplinkResponse.fromJson(String str) => CancelDeeplinkResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CancelDeeplinkResponse.fromMap(Map<String, dynamic> json) => CancelDeeplinkResponse(
        responseMessage: json["response_message"] == null ? null : json["response_message"],
        responseCode: json["response_code"] == null ? null : json["response_code"],
        checksum: json["checksum"] == null ? null : json["checksum"],
      );

  Map<String, dynamic> toMap() => {
        "response_message": responseMessage == null ? null : responseMessage,
        "response_code": responseCode == null ? null : responseCode,
        "checksum": checksum == null ? null : checksum,
      };
}
