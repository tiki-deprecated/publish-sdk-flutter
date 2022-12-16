/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:tiki_sdk_dart/tiki_sdk.dart';
import 'package:tiki_sdk_flutter/tiki_sdk_flutter_req.dart';

class TikiSdkFlutterReqConsentModify extends TikiSdkFlutterReq {
  late String ownershipId;
  late TikiSdkDestination destination;
  late String? about;
  late String? reward;
  late DateTime? expiry;


  @override
  late String requestId;

  TikiSdkFlutterReqConsentModify.fromJson(String jsonReq) {
    Map<String, dynamic> map = jsonDecode(jsonReq);
    ownershipId = map["ownershipId"];
    destination = TikiSdkDestination.fromJson(map["destination"]);
    requestId = map["requestId"];
  }

}
