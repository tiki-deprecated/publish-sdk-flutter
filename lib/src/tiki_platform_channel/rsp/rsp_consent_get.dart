/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:tiki_sdk_dart/consent/consent_model.dart';

import 'rsp.dart';

class RspConsentGet extends Rsp {
  ConsentModel? consent;

  RspConsentGet({this.consent, String? requestId})
      : super(requestId: requestId);

  @override
  String toJson() =>
      jsonEncode({"consent": consent?.toMap(), "requestId": requestId});
}
