import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:tiki_sdk_dart/node/l0_storage.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';
import 'package:tiki_sdk_flutter/tiki_sdk_flutter.dart';

import 'tiki_sdk_flutter_builder.dart';

class TikiSdkFlutterPlatform extends PlatformInterface {
  TikiSdkFlutterPlatform() : super(token: _token);

  final methodChannel = const MethodChannel('tiki_sdk_flutter');

  static late final TikiSdkFlutter tikiSdk;

  static final Object _token = Object();

  static TikiSdkFlutterPlatform _instance = TikiSdkFlutterPlatform();

  static TikiSdkFlutterPlatform get instance => _instance;

  static set instance(TikiSdkFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> methodHandler(MethodCall call) async {
    switch (call.method) {
      case "buildSdk":
        String? apiKey = call.arguments['apiKey'];
        await buildSdk(apiKey: apiKey);
        break;
      case "assignOwnership":
        String source = call.arguments['source'];
        TikiSdkDataTypeEnum type =
            TikiSdkDataTypeEnum.fromValue(call.arguments['type']);
        List<String> contains = call.arguments['contains'];
        String? origin = call.arguments['origin'];
        await tikiSdk.assignOwnership(source, type, contains, origin: origin);
        break;
      case "getConsent":
        String source = call.arguments['source'];
        String? origin = call.arguments['origin'];
        tikiSdk.getConsent(source, origin: origin);
        break;
      case "modifyConsent":
        String ownershipId = call.arguments['ownershipId'];
        TikiSdkDestination destination =
            TikiSdkDestination.fromJson(call.arguments['destination']);
        String? about = call.arguments['about'];
        String? reward = call.arguments['reward'];
        DateTime? expiry = DateTime.fromMillisecondsSinceEpoch(
            call.arguments['expiry'] ~/ 1000);
        await tikiSdk.modifyConsent(ownershipId, destination,
            about: about, reward: reward, expiry: expiry);
        break;
      case "applyConsent":
        String source = call.arguments['source'];
        TikiSdkDestination destination =
            TikiSdkDestination.fromJson(call.arguments['destination']);
        String requestId = call.arguments['requestId'];
        tikiSdk.applyConsent(source, destination, () => callRequest(requestId),
            onBlocked: (val) => blockRequest(requestId, val));
        break;
      default:
        throw Exception('no method handler for method ${call.method}');
    }
  }

  static Future<void> buildSdk({String? apiKey}) async {
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder('flutter test');
    if (apiKey != null) {
      builder.apiKey = apiKey;
    } else {
      builder.l0storage = InjectedStorage(read, write, getAll);
    }
    await builder.build();
    tikiSdk = builder.tikiSdkFlutter;
  }

  static Future<Map<String, Uint8List>> getAll(String address) async {
    Map<String, Uint8List>? response = await instance.methodChannel
        .invokeMapMethod<String, Uint8List>('getAll', {'address': address});
    if (response == null) return {};
    return response;
  }

  static Future<Uint8List?> read(String path) async =>
      await instance.methodChannel
          .invokeMethod<Uint8List>('read', {'path': path});

  static Future<void> write(String path, Uint8List obj) async =>
      await instance.methodChannel
          .invokeMethod('write', {'path': path, 'obj': obj});

  static Future<void> callRequest(String requestId) async =>
      await instance.methodChannel
          .invokeMethod('callRequest', {'requestId': requestId});

  static void blockRequest(String requestId, String val) async =>
      await instance.methodChannel
          .invokeMethod('blockRequest', {'requestId': requestId, 'val': val});
}

class InjectedStorage extends L0Storage {
  final Future<Uint8List?> Function(String) _read;
  final Future<void> Function(String, Uint8List) _write;
  final Future<Map<String, Uint8List>> Function(String) _getAll;

  InjectedStorage(this._read, this._write, this._getAll);

  @override
  Future<Map<String, Uint8List>> getAll(String address) => _getAll(address);

  @override
  Future<Uint8List?> read(String path) async => _read(path);

  @override
  Future<void> write(String path, Uint8List obj) async => _write(path, obj);
}
