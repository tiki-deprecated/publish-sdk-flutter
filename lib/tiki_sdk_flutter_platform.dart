import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:tiki_sdk_dart/consent/consent_model.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';
import 'package:tiki_sdk_flutter/tiki_sdk_flutter.dart';

import 'tiki_sdk_flutter_builder.dart';

class TikiSdkFlutterPlatform extends PlatformInterface {
  static final Object _token = Object();
  static late final TikiSdkFlutter _tikiSdk;
  static TikiSdkFlutterPlatform _instance = TikiSdkFlutterPlatform();

  final methodChannel = const MethodChannel('tiki_sdk_flutter');

  TikiSdkFlutterPlatform() : super(token: _token);

  static TikiSdkFlutterPlatform get instance => _instance;

  static set instance(TikiSdkFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

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
          _success(requestId, 'SDK initialized');
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
          _success(requestId, ownershipId);
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
            _success(requestId, '');
          }else{
            _success(requestId, base64.encode(consentModel.serialize()));
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
          _success(requestId, base64.encode(consentModel.serialize()));
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
              source, destination, () => _success(requestId, ''),
              onBlocked: (val) => _error(requestId, val));
        }catch(e){
          _error(requestId, e.toString());
        }
        break;
      default:
        _error(requestId, 'no method handler for method ${call.method}');
    }
  }

  Future<void> _success(String requestId, String val) async =>
      await instance.methodChannel
          .invokeMethod('successk', {'requestId': requestId, 'val': val});

  void _error(String requestId, String val) async =>
      await instance.methodChannel
          .invokeMethod('error', {'requestId': requestId, 'val': val});
}
