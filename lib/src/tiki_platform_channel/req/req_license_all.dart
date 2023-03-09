/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class ReqLicenseAll {
  String? ptr;
  String? origin;

  ReqLicenseAll.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    ptr = map["ptr"];
    origin = map["origin"];
  }
}
