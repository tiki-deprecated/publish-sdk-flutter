import 'dart:convert';

import 'package:tiki_sdk_dart/tiki_sdk.dart';

import 'rsp.dart';

class RspTitle extends Rsp {
  final TitleRecord? title;
  final String? requestId;

  RspTitle({this.title, this.requestId});

  @override
  String toJson() =>
      jsonEncode({"license": jsonEncondeTitle(title), "request_id": requestId});

  String? jsonEncondeTitle(TitleRecord? title) {
    if (title == null) return "null";
    Map titleMap = {
      "hashedPtr": title.hashedPtr,
      "description": title.description,
      "tags": title.tags.map<String>((titleTag) => titleTag.value),
      "origin": title.origin
    };
    return jsonEncode(titleMap);
  }
}
