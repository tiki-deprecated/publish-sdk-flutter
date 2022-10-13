import 'package:flutter_test/flutter_test.dart';
import 'package:tiki_sdk_flutter_plugin/tiki_sdk_flutter_plugin.dart';
import 'package:tiki_sdk_flutter_plugin/tiki_sdk_flutter_plugin_platform_interface.dart';
import 'package:tiki_sdk_flutter_plugin/tiki_sdk_flutter_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTikiSdkFlutterPluginPlatform
    with MockPlatformInterfaceMixin
    implements TikiSdkFlutterPluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TikiSdkFlutterPluginPlatform initialPlatform =
      TikiSdkFlutterPluginPlatform.instance;

  test('$MethodChannelTikiSdkFlutterPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTikiSdkFlutterPlugin>());
  });

  test('getPlatformVersion', () async {
    TikiSdkFlutterPlugin tikiSdkFlutterPlugin = TikiSdkFlutterPlugin();
    MockTikiSdkFlutterPluginPlatform fakePlatform =
        MockTikiSdkFlutterPluginPlatform();
    TikiSdkFlutterPluginPlatform.instance = fakePlatform;

    expect(await tikiSdkFlutterPlugin.getPlatformVersion(), '42');
  });
}
