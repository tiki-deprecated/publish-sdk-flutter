/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../../../main.dart';
import '../tiki_platform_channel_req.dart';


class TikiPlatformChannelReqConsentApply extends TikiPlatformChannelReq {
  late String source;
  late TikiSdkDestination destination;

  @override
  late String requestId;

  TikiPlatformChannelReqConsentApply.fromJson(String jsonReq) {
    Map<String, dynamic> map = jsonDecode(jsonReq);
    source = map["source"];
    destination = TikiSdkDestination.fromJson(map["destination"]);
    requestId = map["requestId"];
  }
}
