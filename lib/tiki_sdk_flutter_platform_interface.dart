import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tiki_sdk_flutter_method_channel.dart';

abstract class TikiSdkFlutterPlatform extends PlatformInterface {
  /// Constructs a TikiSdkFlutterPlatform.
  TikiSdkFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static TikiSdkFlutterPlatform _instance = MethodChannelTikiSdkFlutter();

  /// The default instance of [TikiSdkFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelTikiSdkFlutter].
  static TikiSdkFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TikiSdkFlutterPlatform] when
  /// they register themselves.
  static set instance(TikiSdkFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
