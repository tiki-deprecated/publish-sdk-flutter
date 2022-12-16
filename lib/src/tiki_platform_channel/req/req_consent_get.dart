/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'req.dart';

class ReqConsentGet extends Req {
  late String source;
  String? origin;

  @override
  late String requestId;

  ReqConsentGet.fromJson(String jsonReq) {
    Map<String, String> map = jsonDecode(jsonReq);
    source = map["source"]!;
    requestId = map["requestId"]!;
    origin = map["origin"];
  }
}
