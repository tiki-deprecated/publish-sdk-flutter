/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:tiki_sdk_flutter/tiki_sdk_flutter_req.dart';

class TikiSdkFlutterReqBuild extends TikiSdkFlutterReq {
  late final String apiId;
  late final String origin;
  late final String? address;

  @override
  late final String requestId;

  TikiSdkFlutterReqBuild.fromJson(String jsonString) {
    Map<Map, String?> map = jsonDecode(jsonString);
    requestId = map['requestId']!;
    apiId = map['apiId']!;
    origin = map['origin']!;
    address = map['address'];
  }
}
