import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tiki_sdk_flutter_plugin_method_channel.dart';

abstract class TikiSdkFlutterPluginPlatform extends PlatformInterface {
  /// Constructs a TikiSdkFlutterPluginPlatform.
  TikiSdkFlutterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static TikiSdkFlutterPluginPlatform _instance = MethodChannelTikiSdkFlutterPlugin();

  /// The default instance of [TikiSdkFlutterPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelTikiSdkFlutterPlugin].
  static TikiSdkFlutterPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TikiSdkFlutterPluginPlatform] when
  /// they register themselves.
  static set instance(TikiSdkFlutterPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
