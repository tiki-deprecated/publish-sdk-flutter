/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../tiki_platform_channel_req.dart';


class TikiPlatformChannelReqOwnershipGet extends TikiPlatformChannelReq {
  late String source;
  String? origin;

  @override
  late String requestId;

  TikiPlatformChannelReqOwnershipGet.fromJson(String jsonReq) {
    Map<String, String?> map = jsonDecode(jsonReq);
    requestId = map["requestId"]!;
    source = map["source"]!;
    origin = map["origin"];
  }
}
