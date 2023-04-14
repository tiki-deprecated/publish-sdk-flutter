/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

/// The request for the `build` method call in the Platform Channel.
///
/// It requires an [publishingId] and an [origin]. If no [address] is provided the SDK
/// will create a new one
class ReqInit {
  late final String publishingId;
  late final String origin;
  late final String id;

  ReqInit.fromJson(String jsonString) {
    Map map = jsonDecode(jsonString);
    publishingId = map['publishingId']!;
    origin = map['origin']!;
    id = map['id'];
  }
}
