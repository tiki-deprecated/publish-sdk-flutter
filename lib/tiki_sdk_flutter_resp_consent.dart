import 'dart:convert';

import 'package:tiki_sdk_dart/consent/consent_model.dart';
import 'package:tiki_sdk_flutter/tiki_sdk_flutter_resp.dart';

class TikiSdkFlutterRespConsent extends TikiSdkFlutterResp {
  ConsentModel? consentModel;

  @override
  String requestId;

  TikiSdkFlutterRespConsent(this.consentModel, this.requestId);

  @override
  String toJson() => jsonEncode(
      {"ownershipModel": consentModel?.toJson(), "requestId": requestId});
}
