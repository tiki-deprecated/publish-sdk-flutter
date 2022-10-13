
import 'tiki_sdk_flutter_plugin_platform_interface.dart';

class TikiSdkFlutterPlugin {
  Future<String?> getPlatformVersion() {
    return TikiSdkFlutterPluginPlatform.instance.getPlatformVersion();
  }
}
