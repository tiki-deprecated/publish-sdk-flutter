/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:tiki_sdk_flutter/tiki_sdk_flutter_resp.dart';

import 'main.dart';

class TikiSdkFlutterRespOwnership extends TikiSdkFlutterResp {
  OwnershipModel? ownershipModel;

  @override
  String requestId;

  TikiSdkFlutterRespOwnership(this.ownershipModel, this.requestId);

  @override
  String toJson() => jsonEncode(
      {"ownershipModel": ownershipModel?.toJson(), "requestId": requestId});
}
