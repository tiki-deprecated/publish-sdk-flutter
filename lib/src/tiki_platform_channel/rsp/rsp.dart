/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

/// The base Response object for native channels.
///
/// The [requestId] parameter is used to identify the request in the native platform.
abstract class Rsp {
  String? requestId;

  Rsp({this.requestId});

  String toJson() => jsonEncode({"requestId": requestId});
}
