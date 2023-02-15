/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:tiki_sdk_dart/tiki_sdk.dart';

/// The request for the `modifyConsent`method call in the Platform Channel.
class ReqConsentModify {
  late String ownershipId;
  late TikiSdkDestination destination;
  String? about;
  String? reward;
  DateTime? expiry;

  ReqConsentModify.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    List? paths = map["destination"]?["paths"];
    List? uses = map["destination"]?["uses"];
    Map<String, List<String>> destMap = {
      "paths": paths?.map<String>((e) => e.toString()).toList() ?? [],
      "uses": uses?.map<String>((e) => e.toString()).toList() ?? [],
    };
    var tikisdkdest = TikiSdkDestination.fromMap(destMap);
    var exp = map["expiry"] != null
        ? DateTime.fromMillisecondsSinceEpoch(map["expiry"])
        : null;
    ownershipId = map["ownershipId"];
    destination = tikisdkdest;
    reward = map["reward"];
    expiry = exp;
  }
}
