/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'req.dart';

class ReqOwnershipGet extends Req {
  late String source;
  String? origin;

  @override
  late String requestId;

  ReqOwnershipGet.fromJson(String jsonReq) {
    Map<String, String?> map = jsonDecode(jsonReq);
    requestId = map["requestId"]!;
    source = map["source"]!;
    origin = map["origin"];
  }
}
