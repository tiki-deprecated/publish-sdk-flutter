/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../tiki_platform_channel_req.dart';


class TikiPlatformChannelReqBuild extends TikiPlatformChannelReq {
  late final String apiId;
  late final String origin;
  late final String? address;

  @override
  late final String requestId;

  TikiPlatformChannelReqBuild.fromJson(String jsonString) {
    Map<Map, String?> map = jsonDecode(jsonString);
    requestId = map['requestId']!;
    apiId = map['apiId']!;
    origin = map['origin']!;
    address = map['address'];
  }
}
