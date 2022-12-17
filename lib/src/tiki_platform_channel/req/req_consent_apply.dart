/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../../../main.dart';
import 'req.dart';

class ReqConsentApply extends Req {
  late String source;
  late TikiSdkDestination destination;

  @override
  late String requestId;

  ReqConsentApply.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    source = map["source"];
    destination = TikiSdkDestination.fromJson(map["destination"]);
    requestId = map["requestId"];
  }
}
