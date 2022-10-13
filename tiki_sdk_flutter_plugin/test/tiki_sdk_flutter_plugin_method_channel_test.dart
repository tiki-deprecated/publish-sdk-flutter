import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiki_sdk_flutter_plugin/tiki_sdk_flutter_plugin_method_channel.dart';

void main() {
  MethodChannelTikiSdkFlutterPlugin platform = MethodChannelTikiSdkFlutterPlugin();
  const MethodChannel channel = MethodChannel('tiki_sdk_flutter_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
