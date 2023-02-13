/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';


import 'package:tiki_sdk_dart/cache/consent/consent_model.dart';

import 'rsp.dart';

/// The response for the `getConsent` and `modifyConsent`method calls in
/// the Platform Channel.
///
/// It returns the [consent]. Null if no consent was given.
class RspConsentGet extends Rsp {
  ConsentModel? consent;

  RspConsentGet({this.consent, String? requestId});

  @override
  String toJson() => jsonEncode({"consent": consent?.toMap()});
}
