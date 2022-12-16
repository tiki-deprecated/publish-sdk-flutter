/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:tiki_sdk_dart/tiki_sdk.dart';

import '../tiki_platform_channel_req.dart';

class TikiPlatformChannelReqConsentModify extends TikiPlatformChannelReq {
  late String ownershipId;
  late TikiSdkDestination destination;
  late String? about;
  late String? reward;
  late DateTime? expiry;


  @override
  late String requestId;

  TikiPlatformChannelReqConsentModify.fromJson(String jsonReq) {
    Map<String, dynamic> map = jsonDecode(jsonReq);
    ownershipId = map["ownershipId"];
    destination = TikiSdkDestination.fromJson(map["destination"]);
    requestId = map["requestId"];
  }

}
