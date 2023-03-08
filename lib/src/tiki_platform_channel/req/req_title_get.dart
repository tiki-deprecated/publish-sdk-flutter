/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

class ReqTitleGet {
  String? id;
  String? origin;

  ReqTitleGet.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    id = map["id"];
    origin = map["origin"];
  }
}
