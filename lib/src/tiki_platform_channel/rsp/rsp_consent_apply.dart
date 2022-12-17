/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'rsp.dart';

class RspConsentApply extends Rsp {
  bool? success;
  String? reason;

  RspConsentApply({this.success, this.reason, String? requestId})
      : super(requestId: requestId);

  @override
  String toJson() => jsonEncode(
      {"success": success, "reason": reason, "requestId": requestId});
}
