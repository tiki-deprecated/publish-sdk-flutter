/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'rsp.dart';

class RspGuard extends Rsp {
  final bool success;
  final String? reason;

  RspGuard({this.success = false, this.reason});

  @override
  String toJson() => jsonEncode({"success": success, "reason": reason});
}
