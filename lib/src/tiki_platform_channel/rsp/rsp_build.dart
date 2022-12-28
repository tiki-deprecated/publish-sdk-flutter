/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'rsp.dart';

/// The response for the `build` method call in the Platform Channel.
///
/// It returns the [address] of the built node.
class RspBuild extends Rsp {
  final String? address;

  RspBuild({this.address, String? requestId});

  @override
  String toJson() => jsonEncode({"address": address});
}
