/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../../../main.dart';

class ReqLicenseLatest {
  String? ptr;

  ReqLicenseLatest.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    ptr = map["ptr"];
  }
}