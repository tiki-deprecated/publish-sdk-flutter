/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:tiki_sdk_flutter/tiki_sdk_flutter_req.dart';

import 'main.dart';

class TikiSdkFlutterReqOwnership extends TikiSdkFlutterReq {
  late String source;
  late TikiSdkDataTypeEnum type;
  late List<String> contains;
  late String? about;
  late String? origin;

  @override
  late String requestId;

  TikiSdkFlutterReqOwnership.fromJson(String jsonReq) {
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
