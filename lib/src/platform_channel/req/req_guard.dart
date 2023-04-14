/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../../../main.dart';

class ReqGuard {
  String? ptr;
  List<LicenseUsecase> uses = [];
  List<String>? destinations;
  String? origin;

  ReqGuard.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    ptr = map["ptr"];
    destinations =
        map["destinations"]?.map<String>((e) => e.toString()).toList();
    uses = map["usecases"]
            ?.map<LicenseUsecase>((e) => LicenseUsecase.from(e.toString()))
            .toList() ??
        [];
    origin = map["origin"];
  }
}
