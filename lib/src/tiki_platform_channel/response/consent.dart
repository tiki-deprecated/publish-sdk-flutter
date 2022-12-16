import 'dart:convert';

import 'package:tiki_sdk_dart/consent/consent_model.dart';

import '../tiki_platform_channel_resp.dart';

class TikiPlatformChannelRespConsent extends TikiPlatformChannelResp {
  ConsentModel? consentModel;

  TikiPlatformChannelRespConsent(this.consentModel, requestId) : super(requestId);

  @override
  String toJson() => jsonEncode(
      {"ownershipModel": consentModel?.toJson(), "requestId": requestId});
}
