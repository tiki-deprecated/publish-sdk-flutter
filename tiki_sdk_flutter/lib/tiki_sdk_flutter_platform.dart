import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tiki_sdk_dart/consent/consent_model.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';
import 'package:tiki_sdk_flutter/tiki_sdk_flutter.dart';

import 'tiki_sdk_flutter_builder.dart';

class TikiSdkFlutterPlatform{
  static late final TikiSdkFlutter _tikiSdk;

  final methodChannel = const MethodChannel('tiki_sdk_flutter');

  Future<void> methodHandler(MethodCall call) async {
    String requestId = call.arguments['requestId'] ?? '0';
    switch (call.method) {
      case "build":
        try {
          String? apiKey = call.arguments['apiKey'];
          String? origin = call.arguments['origin'];
          TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
            ..origin(origin!)
            ..apiKey(apiKey!);
          _tikiSdk = await builder.build();
          _success(requestId);
        }catch(e){
          _error(requestId, e.toString());
        }
        break;
      case "assignOwnership":
        try{
          String source = call.arguments['source'];
          TikiSdkDataTypeEnum type =
              TikiSdkDataTypeEnum.fromValue(call.arguments['type']);
          List<String> contains = call.arguments['contains'];
          String? origin = call.arguments['origin'];
          String ownershipId = await _tikiSdk.assignOwnership(source, type, contains, origin: origin);
          _success(requestId, response: ownershipId);
        }catch(e){
          _error(requestId, e.toString());
        }
        break;
      case "getConsent":
        try {
          String source = call.arguments['source'];
          String? origin = call.arguments['origin'];
          ConsentModel? consentModel = _tikiSdk.getConsent(source, origin: origin);
          if(consentModel == null) {
            _success(requestId, response: consentModel?.toJson());
          }else{
            _success(requestId, response : base64.encode(consentModel.serialize()));
          }
        }catch(e){
          _error(requestId, e.toString());
        }
        break;
      case "modifyConsent":
        try{
          String ownershipId = call.arguments['ownershipId'];
          TikiSdkDestination destination =
              TikiSdkDestination.fromJson(call.arguments['destination']);
          String? about = call.arguments['about'];
          String? reward = call.arguments['reward'];
          DateTime? expiry =
              DateTime.fromMillisecondsSinceEpoch(call.arguments['expiry']);
          ConsentModel consentModel = await _tikiSdk.modifyConsent(ownershipId, destination,
              about: about, reward: reward, expiry: expiry);
          _success(requestId, response: base64.encode(consentModel.serialize()));
        }catch(e){
        _error(requestId, e.toString());
        }
        break;
      case "applyConsent":
        try {
          String source = call.arguments['source'];
          TikiSdkDestination destination =
          TikiSdkDestination.fromJson(call.arguments['destination']);
          String requestId = call.arguments['requestId'];
          _tikiSdk.applyConsent(
              source, destination, () => _success(requestId),
              onBlocked: (val) => _error(requestId, val));
        }catch(e){
          _error(requestId, e.toString());
        }
        break;
      default:
        _error(requestId, 'no method handler for method ${call.method}');
    }
  }

  Future<void> _success(String requestId, {String? response}) async =>
      await methodChannel
          .invokeMethod('success', {'requestId': requestId, 'response': response});

  void _error(String requestId, String response) async =>
      await methodChannel
          .invokeMethod('error', {'requestId': requestId, 'response': response});
}
