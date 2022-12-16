import 'dart:convert';

class TikiPlatformChannelResp {
  String requestId = "";

  TikiPlatformChannelResp(this.requestId);

  String toJson() => jsonEncode({"resquestId":requestId});
}
