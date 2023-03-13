/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../../../main.dart';

class ReqTitle {
  String? ptr;
  List<TitleTag> tags = [];
  String? description;
  String? origin;

  ReqTitle.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    ptr = map["ptr"];
    origin = map["origin"];
    description = map["description"];

    for (String tag
        in map["tags"].map<String>((e) => e.toString()).toList() ?? []) {
      tags.add(TitleTag.from(tag));
    }
  }
}
