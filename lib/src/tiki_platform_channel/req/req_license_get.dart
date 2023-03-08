/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../../../main.dart';

class ReqLicenseGet {
  String? id;

  ReqLicenseGet.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    id = map["id"];
  }
}
