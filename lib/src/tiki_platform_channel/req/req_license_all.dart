/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../../../main.dart';

class ReqLicenseAll {
  String? ptr;

  ReqLicenseAll.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    ptr = map["ptr"];
  }
}