/*
 * Created by Nonthawatt Phongwittayapanu on 2/9/21 3:22 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

import 'dart:convert';

class Merchant {
  Merchant({
    this.merchantId,
    this.redirectUrl,
    this.notificationUrl,
    this.merchantData,
  });

  String? merchantId;
  String? redirectUrl;
  String? notificationUrl;
  List<MerchantData>? merchantData;

  factory Merchant.fromJson(String str) => Merchant.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Merchant.fromMap(Map<String, dynamic> json) => Merchant(
        merchantId: json["merchant_id"],
        merchantData: List<MerchantData>.from(json["merchant_data"].map((x) => MerchantData.fromMap(x))),
        redirectUrl: json["redirect_url"],
        notificationUrl: json["notification_url"],
      );

  Map<String, dynamic> toMap() => {
        "merchant_id": merchantId,
        "merchant_data": List<dynamic>.from(merchantData?.map((x) => x.toMap()) ?? []),
        "redirect_url": redirectUrl,
        "notification_url": notificationUrl,
      };
}

class MerchantData {
  MerchantData({
    this.item,
  });

  String? item;

  factory MerchantData.fromJson(String str) => MerchantData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MerchantData.fromMap(Map<String, dynamic> json) => MerchantData(
        item: json["item"],
      );

  Map<String, dynamic> toMap() => {
        "item": item,
      };
}
