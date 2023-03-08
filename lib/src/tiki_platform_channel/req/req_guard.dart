/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../../../main.dart';

class ReqGuard {
  String? ptr;
  List<LicenseUse> uses = const [];

  ReqGuard.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    ptr = map["ptr"];

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
  }
}