/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:tiki_sdk_flutter/tiki_sdk_flutter_resp.dart';

import 'main.dart';

class TikiSdkFlutterRespBuild implements TikiSdkFlutterResp {
  final TikiSdk tikiSdk;

  @override
  String get requestId => "build";

  TikiSdkFlutterRespBuild(this.tikiSdk);

  @override
  String toJson() => jsonEncode({"address": tikiSdk.address});
}
