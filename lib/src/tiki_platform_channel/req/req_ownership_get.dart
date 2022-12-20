/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'req.dart';

/// The request for the `getOwnership` method call in the Platform Channel.
class ReqOwnershipGet extends Req {
  late String source;
  String? origin;

  @override
  late String requestId;

  ReqOwnershipGet.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    requestId = map["requestId"]!;
    source = map["source"]!;
    origin = map["origin"];
  }
}
