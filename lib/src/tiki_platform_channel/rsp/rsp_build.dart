/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'rsp.dart';

class RspBuild extends Rsp {
  final String? address;

  RspBuild({this.address, String? requestId}) : super(requestId: requestId);

  @override
  String toJson() => jsonEncode({"address": address, "requestId": requestId});
}
