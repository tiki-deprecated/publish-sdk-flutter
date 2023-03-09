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
      "ptr": title.ptr,
      "description": title.description,
      "tags": title.tags.map<Map<String, String>>((titleTag) =>
      {
        "titleTagEnum": titleTag.value
      }),
      "origin": title.origin
    };
    return jsonEncode(titleMap);
  }
}
