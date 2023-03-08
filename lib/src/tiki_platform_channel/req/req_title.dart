/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../../../main.dart';

class ReqTitle {
  String? ptr;
  List<TitleTag> tags = const [];
  String? description;

  ReqTitle.fromJson(String jsonReq) {
    Map map = jsonDecode(jsonReq);
    ptr = map["ptr"];
    description = map["description"];

    for(String tag in map["tags"]){
      tags.add(TitleTag.from(tag));
    }
  }
}
