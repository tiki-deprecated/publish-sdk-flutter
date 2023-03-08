/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../../../main.dart';

class ReqLicense {
  String? ptr;
  String? terms;
  String? titleDescription;
  String? licenseDescription;
  String? origin;
  List<LicenseUse> uses = [];
  List<TitleTag> tags = [];
  DateTime? expiry;

  ReqLicense.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    ptr = map["ptr"];
    terms = map["terms"];
    titleDescription = map["titleDescription"];
    licenseDescription = map["licenseDescription"];
    expiry = map["expiry"] != null ? DateTime.fromMillisecondsSinceEpoch(map["expiry"]) : null;
    origin = map["origin"];

    List useCasesList = map["uses"] ?? [];
    for (var usecase in useCasesList) {
      List? destinationsList = usecase["destinations"];
      List? usesList = usecase["usecases"];
      Map<String, List<String>> usesMap = {
        "destinations":
          destinationsList?.map<String>((e) => e.toString()).toList() ?? [],
        "usecases":
          usesList?.map<String>((e) => e.toString()).toList() ?? [],
      };
      uses.add(LicenseUse.fromMap(usesMap));
    }

    for (String tag in map["tags"]) {
      tags.add(TitleTag.from(tag));
    }
  }
}
