/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class ReqLicenseGet {
  String? id;
  String? origin;

  ReqLicenseGet.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    id = map["id"];
    origin = map["origin"];
  }
}
