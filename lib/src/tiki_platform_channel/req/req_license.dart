/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../../../main.dart';

class ReqLicense {
  String? ptr;
  String? terms;
  List<LicenseUse> uses = const [];
  List<TitleTag> tags = const [];
  String? titleDescription;
  String? licenseDescription;
  DateTime? expiry;

  ReqLicense.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    ptr = map["ptr"];
    terms = map["terms"];
    titleDescription = map["titleDescription"];
    licenseDescription = map["licenseDescription"];
    expiry = DateTime.fromMillisecondsSinceEpoch(map["expiry"]);

    List<Map<String, List<String>>> useCasesList = map["usecase"] ?? [];
    for(Map<String, List<String>?> usecase in useCasesList){
      List? destinationsList = usecase["destinations"];
      List? usesList = usecase["uses"];
      Map<String, List<String>> usesMap = {
        "destinations": usesList?.map<String>((e) => e.toString()).toList() ?? [],
        "uses": destinationsList?.map<String>((e) => e.toString()).toList() ?? [],
      };
      uses.add(LicenseUse.fromMap(usesMap));
    }

    for(String tag in map["tags"]){
      tags.add(TitleTag.from(tag));
    }
  }
}
