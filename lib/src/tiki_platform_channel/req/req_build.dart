/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'req.dart';

/// The request for the `build` method call in the Platform Channel.
///
/// It requires an [apiId] and an [origin]. If no [address] is provided the SDK
/// will create a new one
class ReqBuild extends Req {
  late final String apiId;
  late final String origin;
  late final String? address;

  @override
  late final String requestId;

  ReqBuild.fromJson(String jsonString) {
    Map map = jsonDecode(jsonString);
    requestId = map['requestId']!;
    apiId = map['apiId']!;
    origin = map['origin']!;
    address = map['address'];
  }
}
