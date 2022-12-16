/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../tiki_platform_channel_req.dart';


class TikiPlatformChannelReqConsentGet extends TikiPlatformChannelReq {
  late String source;
  String? origin;

  @override
  late String requestId;

  TikiPlatformChannelReqConsentGet.fromJson(String jsonReq) {
    Map<String, String> map = jsonDecode(jsonReq);
    source = map["source"]!;
    requestId = map["requestId"]!;
    origin = map["origin"];
  }
}
