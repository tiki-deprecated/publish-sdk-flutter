/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'rsp.dart';

/// The response for the `build` method call in the Platform Channel.
///
/// It returns the [address] of the built node.
class RspInit extends Rsp {
  final String? address;
  final String? requestId;

  RspInit({this.address, this.requestId});

  @override
  String toJson() => jsonEncode({"address": address, "request_id": requestId});
}
