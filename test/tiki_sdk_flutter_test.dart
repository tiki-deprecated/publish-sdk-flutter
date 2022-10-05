import 'package:flutter_test/flutter_test.dart';
import 'package:tiki_sdk_flutter/tiki_sdk_flutter.dart';
import 'package:tiki_sdk_flutter/tiki_sdk_flutter_platform_interface.dart';
import 'package:tiki_sdk_flutter/tiki_sdk_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTikiSdkFlutterPlatform
    with MockPlatformInterfaceMixin
    implements TikiSdkFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TikiSdkFlutterPlatform initialPlatform = TikiSdkFlutterPlatform.instance;

  test('$MethodChannelTikiSdkFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTikiSdkFlutter>());
  });

  test('getPlatformVersion', () async {
    TikiSdkFlutter tikiSdkFlutterPlugin = TikiSdkFlutter();
    MockTikiSdkFlutterPlatform fakePlatform = MockTikiSdkFlutterPlatform();
    TikiSdkFlutterPlatform.instance = fakePlatform;

    expect(await tikiSdkFlutterPlugin.getPlatformVersion(), '42');
  });
}
