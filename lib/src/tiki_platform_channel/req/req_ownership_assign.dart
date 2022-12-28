/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../../../main.dart';

/// The request for the `assignOwnership` method call in the Platform Channel.
class ReqOwnershipAssign {
  late String source;
  late TikiSdkDataTypeEnum type;
  late List<String> contains;
  late String? about;
  String? origin;

  ReqOwnershipAssign.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    source = map["source"];
    type = TikiSdkDataTypeEnum.fromValue(map["type"]);
    contains = map["contains"].map<String>((e) => e.toString()).toList();
    about = map["about"];
    origin = map["origin"];
  }
}
