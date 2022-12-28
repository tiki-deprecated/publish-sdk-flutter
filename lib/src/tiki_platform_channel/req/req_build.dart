/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

/// The request for the `build` method call in the Platform Channel.
///
/// It requires an [apiId] and an [origin]. If no [address] is provided the SDK
/// will create a new one
class ReqBuild {
  late final String apiId;
  late final String origin;
  late final String? address;

  ReqBuild.fromJson(String jsonString) {
    Map map = jsonDecode(jsonString);
    apiId = map['apiId']!;
    origin = map['origin']!;
    address = map['address'];
  }
}
