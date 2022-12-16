import 'dart:convert';

import 'tiki_sdk_flutter_resp.dart';

class TikiSdkFlutterRespApply extends TikiSdkFlutterResp {
  @override
  String requestId;

  TikiSdkFlutterRespApply(this.requestId);

  @override
  String toJson() => jsonEncode({"requestId": requestId});
}
