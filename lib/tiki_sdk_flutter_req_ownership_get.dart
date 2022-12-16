/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:tiki_sdk_flutter/tiki_sdk_flutter_req.dart';

class TikiSdkFlutterReqOwnershipGet extends TikiSdkFlutterReq {
  late String source;
  String? origin;

  @override
  late String requestId;

  TikiSdkFlutterReqOwnershipGet.fromJson(String jsonReq) {
    Map<String, String?> map = jsonDecode(jsonReq);
    requestId = map["requestId"]!;
    source = map["source"]!;
    origin = map["origin"];
  }
}
