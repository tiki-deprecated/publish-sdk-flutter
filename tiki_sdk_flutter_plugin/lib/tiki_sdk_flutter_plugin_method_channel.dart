import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tiki_sdk_flutter_plugin_platform_interface.dart';

/// An implementation of [TikiSdkFlutterPluginPlatform] that uses method channels.
class MethodChannelTikiSdkFlutterPlugin extends TikiSdkFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tiki_sdk_flutter_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
