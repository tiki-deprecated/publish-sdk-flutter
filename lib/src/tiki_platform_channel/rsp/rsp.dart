/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class Rsp {
  String? requestId;

  Rsp({this.requestId});

  String toJson() => jsonEncode({"requestId": requestId});
}
