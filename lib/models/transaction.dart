/*
 * Created by Nonthawatt Phongwittayapanu on 2/9/21 3:22 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

import 'dart:convert';

class Transaction {
  Transaction({
    this.merchantReference,
    this.preferredAgent,
    this.productDescription,
    this.amount,
    this.currencyCode,
    this.paymentInfo,
    this.paymentExpiry,
    this.userDefined1,
    this.userDefined2,
    this.userDefined3,
    this.userDefined4,
    this.userDefined5,
  });

  String? merchantReference;
  String? preferredAgent;
  String? productDescription;
  String? amount;
  String? currencyCode;
  String? paymentInfo;
  String? userDefined1;
  String? userDefined2;
  String? userDefined3;
  String? userDefined4;
  String? userDefined5;
  String? paymentExpiry;

  factory Transaction.fromJson(String str) => Transaction.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
        merchantReference: json["merchant_reference"] == null ? null : json["merchant_reference"],
        preferredAgent: json["preferred_agent"] == null ? null : json["preferred_agent"],
        productDescription: json["product_description"] == null ? null : json["product_description"],
        amount: json["amount"] == null ? null : json["amount"],
        currencyCode: json["currency_code"] == null ? null : json["currency_code"],
        paymentInfo: json["payment_info"] == null ? null : json["payment_info"],
        paymentExpiry: json["payment_expiry"] == null ? null : json["payment_expiry"],
        userDefined1: json["user_defined_1"] == null ? null : json["user_defined_1"],
        userDefined2: json["user_defined_2"] == null ? null : json["user_defined_2"],
        userDefined3: json["user_defined_3"] == null ? null : json["user_defined_3"],
        userDefined4: json["user_defined_4"] == null ? null : json["user_defined_4"],
        userDefined5: json["user_defined_5"] == null ? null : json["user_defined_5"],
      );

  Map<String, dynamic> toMap() => {
        "merchant_reference": merchantReference == null ? null : merchantReference,
        "preferred_agent": preferredAgent == null ? null : preferredAgent,
        "product_description": productDescription == null ? null : productDescription,
        "amount": amount == null ? null : amount,
        "currency_code": currencyCode == null ? null : currencyCode,
        "payment_info": paymentInfo == null ? null : paymentInfo,
        "payment_expiry": paymentExpiry == null ? null : paymentExpiry,
        "user_defined_1": userDefined1 == null ? null : userDefined1,
        "user_defined_2": userDefined2 == null ? null : userDefined2,
        "user_defined_3": userDefined3 == null ? null : userDefined3,
        "user_defined_4": userDefined4 == null ? null : userDefined4,
        "user_defined_5": userDefined5 == null ? null : userDefined5,
      };
}
