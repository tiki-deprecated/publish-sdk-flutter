/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'rsp.dart';

/// The response for the `applyConsent` method call in the Platform Channel.
///
/// It returns if the consent was applied in the [success] field.
/// For failed requests, a [reason] should be provided.
class RspConsentApply extends Rsp {
  bool? success;
  String? reason;

  RspConsentApply({this.success, this.reason, String? requestId});

  @override
  String toJson() => jsonEncode({"success": success, "reason": reason});
}
