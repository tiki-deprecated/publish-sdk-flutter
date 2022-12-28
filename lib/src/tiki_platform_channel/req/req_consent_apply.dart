/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../../../main.dart';

/// The request for the `applyConsent` method call in the Platform Channel.
///
/// It uses the [source] and [destination] to verify if the consent was given.
class ReqConsentApply {
  late String source;
  late TikiSdkDestination destination;

  ReqConsentApply.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    List? paths = map["destination"]?["paths"];
    List? uses = map["destination"]?["paths"];
    Map<String, List<String>> destMap = {
      "paths": paths?.map<String>((e) => e.toString()).toList() ?? [],
      "uses": uses?.map<String>((e) => e.toString()).toList() ?? [],
    };
    var tikisdkdest = TikiSdkDestination.fromMap(destMap);
    source = map["source"];
    destination = tikisdkdest;
  }
}
