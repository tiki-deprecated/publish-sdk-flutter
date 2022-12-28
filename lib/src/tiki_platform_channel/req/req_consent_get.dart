/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

/// The request for the `getConsent` call in the Platform Channel.
class ReqConsentGet {
  late String source;
  String? origin;

  ReqConsentGet.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    source = map["source"]!;
    origin = map["origin"];
  }
}
