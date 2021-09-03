/*
 * Created by Nonthawatt Phongwittayapanu on 2/9/21 3:22 PM
 * Copyright © 2021 2C2P. All rights reserved.
 */

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:onetwothree_sdk/models/response/cancel_deeplink_response.dart';
import 'package:onetwothree_sdk/models/response/get_deeplink_status_response.dart';
import 'package:onetwothree_sdk/models/response/start_deeplink_response.dart';

import 'models/buyer.dart';
import 'models/merchant.dart';
import 'models/transaction.dart';

class OneTwoThreeSDK {
  static const MethodChannel _channel = const MethodChannel('onetwothree_sdk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  ///  Initialize OneTwoThreeSDK Service
  ///  * [isProduction] (Required) - Indicates environment uses in OneTwoThreeSDK
  ///                 (FALSE - UAT Environment (default), TRUE - Production Environment)
  ///  * [checkSumKey] (Required) - A key to calculate checksum for requests ans responses.
  ///  * [publicKey] (Required) - A public key to encrypt requests from API.
  ///  * [privateKey] (Required) - A private key to decrypt responses from API.
  ///  * [passphrase] (Required) - A passphrase to access the private key.
  ///  * [bksPassphrase] (Android Required) - A bkspassphrase that provided when generate the private key.
  static Future<bool> initialize({
    required bool isProduction,
    required String checkSumKey,
    required String publicKey,
    required String privateKey,
    required String passphrase,

    /// For Android Only
    required String bksPassphrase,
  }) async {
    return await _channel.invokeMethod('initialize', {
      'isProduction': isProduction,
      'checkSumKey': checkSumKey,
      'publicKey': publicKey,
      'privateKey': privateKey,
      'passphrase': passphrase,
      'bksPassphrase': bksPassphrase,
    });
  }

  /// Returns a JSON response or if an error occurred will be throw exception.
  /// This type of payment is to direct an end user to a bank mobile application. After the end user completes payment via mobile banking, user will be directed back to merchant mobile application.
  ///  * [merchant] (Required) - Merchant data
  ///  * [transaction] (Required) - Transaction data
  ///  * [buyer] (Required) - Buyer data
  static Future<StartDeeplinkResponse> startDeeplink({
    required Merchant merchant,
    required Transaction transaction,
    required Buyer buyer,
  }) async {
    var result = await _channel.invokeMethod('startDeeplink', {
      'merchant': merchant.toJson(),
      'transaction': transaction.toJson(),
      'buyer': buyer.toJson(),
    });
    return StartDeeplinkResponse.fromJson(result);
  }

  /// Returns a JSON response or if an error occurred will be throw exception.
  /// Merchant can check deeplink payment status for each specific payment code.
  ///  * [merchantId] (Required) - Merchant ID
  ///  * [merchantReference] (Conditional) - Optional if 'paymentCode' is presented and vice versa.
  ///  * [paymentCode] (Conditional) - Optional if 'merchantReference' is presented and vice versa.
  static Future<GetDeeplinkStatusResponse> getDeeplinkStatus({
    String merchantId = '',
    String paymentCode = '',
    String merchantReference = '',
  }) async {
    var result = await _channel.invokeMethod('getDeeplinkStatus', {
      'merchantId': merchantId,
      'paymentCode': paymentCode,
      'merchantReference': merchantReference,
    });
    return GetDeeplinkStatusResponse.fromJson(result);
  }

  /// Returns a JSON response or if an error occurred will be throw exception.
  /// Merchant can cancel an existing pending deeplink transaction for each specific payment code.
  ///  * [merchantId] (Required) - Merchant ID
  ///  * [merchantReference] (Conditional) - Optional if 'paymentCode' is presented and vice versa.
  ///  * [paymentCode] (Conditional) - Optional if 'merchantReference' is presented and vice versa.
  static Future<CancelDeeplinkResponse> cancelDeeplink({
    String merchantId = '',
    String paymentCode = '',
    String merchantReference = '',
  }) async {
    var result = await _channel.invokeMethod('cancelDeeplink', {
      'merchantId': merchantId,
      'paymentCode': paymentCode,
      'merchantReference': merchantReference,
    });
    return CancelDeeplinkResponse.fromJson(result);
  }
}
