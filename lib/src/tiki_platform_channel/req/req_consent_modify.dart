/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:tiki_sdk_dart/tiki_sdk.dart';

import 'req.dart';

class ReqConsentModify extends Req {
  late String ownershipId;
  late TikiSdkDestination destination;
  String? about;
  String? reward;
  DateTime? expiry;

  @override
  late String requestId;

  ReqConsentModify.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    List? paths = map["destination"]?["paths"];
    List? uses = map["destination"]?["paths"];
    Map<String, List<String>> destMap = {
      "paths" : paths?.map<String>((e) => e.toString()).toList() ?? [],
      "uses" : uses?.map<String>((e) => e.toString()).toList() ?? [],
    };
    var tikisdkdest = TikiSdkDestination.fromMap(destMap);
    var exp = map["expiry"] != null ?
      DateTime.fromMillisecondsSinceEpoch(map["expiry"]) : null;
    ownershipId = map["ownershipId"];
    destination = tikisdkdest;
    requestId = map["requestId"];
    reward = map["reward"];
    expiry = exp;
  }
}
