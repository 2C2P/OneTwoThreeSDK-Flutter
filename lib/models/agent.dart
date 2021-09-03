/*
 * Created by Nonthawatt Phongwittayapanu on 2/9/21 5:15 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

import 'dart:convert';

class Agent {
  Agent({
    this.slipURL,
    this.slipImage,
    this.paymentDate,
    this.paymentAccount,
    this.reference,
  });

  String? slipURL;
  String? slipImage;
  String? paymentDate;
  String? paymentAccount;
  String? reference;

  factory Agent.fromJson(String str) => Agent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Agent.fromMap(Map<String, dynamic> json) => Agent(
        slipURL: json["slip_url"] == null ? null : json["slip_url"],
        slipImage: json["slip_image"] == null ? null : json["slip_image"],
        paymentDate: json["payment_date"] == null ? null : json["payment_date"],
        paymentAccount: json["payment_account"] == null ? null : json["payment_account"],
        reference: json["agent_reference"] == null ? null : json["agent_reference"],
      );

  Map<String, dynamic> toMap() => {
        "slip_url": slipURL == null ? null : slipURL,
        "slip_image": slipImage == null ? null : slipImage,
        "payment_date": paymentDate == null ? null : paymentDate,
        "payment_account": paymentAccount == null ? null : paymentAccount,
        "agent_reference": reference == null ? null : reference,
      };
}
