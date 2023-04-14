/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class ReqLicenseLatest {
  String? ptr;
  String? origin;

  ReqLicenseLatest.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    ptr = map["ptr"];
    origin = map["origin"];
  }
}
