import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tiki_sdk_flutter_platform_interface.dart';

/// An implementation of [TikiSdkFlutterPlatform] that uses method channels.
class MethodChannelTikiSdkFlutter extends TikiSdkFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tiki_sdk_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
