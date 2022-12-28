/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

/// The request for the `getOwnership` method call in the Platform Channel.
class ReqOwnershipGet {
  late String source;
  String? origin;

  ReqOwnershipGet.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    source = map["source"]!;
    origin = map["origin"];
  }
}
