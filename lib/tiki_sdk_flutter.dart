
import 'tiki_sdk_flutter_platform_interface.dart';

class TikiSdkFlutter {
  Future<String?> getPlatformVersion() {
    return TikiSdkFlutterPlatform.instance.getPlatformVersion();
  }
}
