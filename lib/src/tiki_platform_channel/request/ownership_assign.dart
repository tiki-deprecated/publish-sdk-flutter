/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';


import '../../../main.dart';
import '../tiki_platform_channel_req.dart';

class TikiPlatformChannelReqOwnership extends TikiPlatformChannelReq {
  late String source;
  late TikiSdkDataTypeEnum type;
  late List<String> contains;
  late String? about;
  late String? origin;

  @override
  late String requestId;

  TikiPlatformChannelReqOwnership.fromJson(String jsonReq) {
    Map<String, dynamic> map = jsonDecode(jsonReq);
    requestId = map["requestId"];
    source = map["source"];
    type = TikiSdkDataTypeEnum.fromValue(map["type"]);
    contains =
        jsonDecode(map["contains"]).map<String>((e) => e.toString()).asList();
    about = map["about"];
    origin = map["origin"];
  }
}
