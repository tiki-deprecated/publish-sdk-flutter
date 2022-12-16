/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:tiki_sdk_flutter/tiki_sdk_flutter_req.dart';

import 'main.dart';

class TikiSdkFlutterReqConsentApply extends TikiSdkFlutterReq {
  late String source;
  late TikiSdkDestination destination;

  @override
  late String requestId;

  TikiSdkFlutterReqConsentApply.fromJson(String jsonReq) {
    Map<String, dynamic> map = jsonDecode(jsonReq);
    source = map["source"];
    destination = TikiSdkDestination.fromJson(map["destination"]);
    requestId = map["requestId"];
  }
}
