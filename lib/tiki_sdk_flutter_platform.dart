import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';
import 'package:tiki_sdk_flutter/tiki_sdk_flutter.dart';

import 'tiki_sdk_flutter_builder.dart';
import 'utils/injected_storage.dart';

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
    switch (call.method) {
      case "build":
        String? apiKey = call.arguments['apiKey'];
        String? origin = call.arguments['origin'];
        TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
          ..origin(origin!)
          ..apiKey(apiKey!);
        _tikiSdk = await builder.build();
        break;
      case "assignOwnership":
        String source = call.arguments['source'];
        TikiSdkDataTypeEnum type =
            TikiSdkDataTypeEnum.fromValue(call.arguments['type']);
        List<String> contains = call.arguments['contains'];
        String? origin = call.arguments['origin'];
        await _tikiSdk.assignOwnership(source, type, contains, origin: origin);
        break;
      case "getConsent":
        String source = call.arguments['source'];
        String? origin = call.arguments['origin'];
        _tikiSdk.getConsent(source, origin: origin);
        break;
      case "modifyConsent":
        String ownershipId = call.arguments['ownershipId'];
        TikiSdkDestination destination =
            TikiSdkDestination.fromJson(call.arguments['destination']);
        String? about = call.arguments['about'];
        String? reward = call.arguments['reward'];
        DateTime? expiry = DateTime.fromMillisecondsSinceEpoch(call.arguments['expiry']);
        await _tikiSdk.modifyConsent(ownershipId, destination,
            about: about, reward: reward, expiry: expiry);
        break;
      case "applyConsent":
        String source = call.arguments['source'];
        TikiSdkDestination destination =
            TikiSdkDestination.fromJson(call.arguments['destination']);
        String requestId = call.arguments['requestId'];
        _tikiSdk.applyConsent(source, destination, () => _callRequest(requestId),
            onBlocked: (val) => _blockRequest(requestId, val));
        break;
      default:
        throw Exception('no method handler for method ${call.method}');
    }
  }

  Future<void> _callRequest(String requestId) async =>
      await instance.methodChannel
          .invokeMethod('callRequest', {'requestId': requestId});

  void _blockRequest(String requestId, String val) async =>
      await instance.methodChannel
          .invokeMethod('blockRequest', {'requestId': requestId, 'val': val});
}