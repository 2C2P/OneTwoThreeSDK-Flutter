/*
 * Created by Nonthawatt Phongwittayapanu on 2/9/21 3:22 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

import 'dart:convert';

class Buyer {
  Buyer({
    this.email,
    this.mobile,
    this.language,
    this.os,
    this.notifyBuyer,
    this.title,
    this.name,
    this.surname,
  });

  String? email;
  String? mobile;
  String? language;
  String? os;
  String? title;
  String? name;
  String? surname;
  bool? notifyBuyer;

  factory Buyer.fromJson(String str) => Buyer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Buyer.fromMap(Map<String, dynamic> json) => Buyer(
        email: json["buyer_email"] == null ? null : json["buyer_email"],
        mobile: json["buyer_mobile"] == null ? null : json["buyer_mobile"],
        language: json["buyer_language"] == null ? null : json["buyer_language"],
        os: json["buyer_os"] == null ? null : json["buyer_os"],
        notifyBuyer: json["notify_buyer"] == null ? null : json["notify_buyer"],
        title: json["buyer_title"] == null ? null : json["buyer_title"],
        name: json["buyer_name"] == null ? null : json["buyer_name"],
        surname: json["buyer_surname"] == null ? null : json["buyer_surname"],
      );

  Map<String, dynamic> toMap() => {
        "buyer_email": email == null ? null : email,
        "buyer_mobile": mobile == null ? null : mobile,
        "buyer_language": language == null ? null : language,
        "buyer_os": os == null ? null : os,
        "notify_buyer": notifyBuyer == null ? null : notifyBuyer,
        "buyer_title": title == null ? null : title,
        "buyer_name": name == null ? null : name,
        "buyer_surname": surname == null ? null : surname,
      };
}
